---
title: Java中synchronized关键字与JDK1.5中显示Lock操作
---
本文主要是总结synchronized关键字与JDK1.5中Lock的操作。这里不谈论线程安全问题，线程安全问题是一个比较广而深的问题（volatile关键字、JMM内存模型、线程与主内存和工作内存的交互关系等）。
同步使用的前提：
1，必须是两个或者两个以上的线程。
2，必须是多个线程使用同一个锁。
这是才可以称为这些线程被同步了。

## synchronized关键字
		class Resource {
		
			public void methodOne(Object obj) {
				System.out.println("进入methodOne()，" + obj);
				synchronized (obj) {
					System.out
							.println(System.currentTimeMillis() + "-同步代码块："
									+ Thread.currentThread().getName() + "，锁="
									+ obj.toString());
					sleep();
				}
			}
		
			public synchronized void methodTwo(String str) {
				System.out.println("进入methodTwo()，" + str);
				System.out.println(System.currentTimeMillis() + "-同步方法："
						+ Thread.currentThread().getName());
				sleep();
			}
		
			public static synchronized void methodThree(String str) {
				System.out.println("进入methodThree()，" + str);
				System.out.println(System.currentTimeMillis() + "-静态同步方法："
						+ Thread.currentThread().getName());
				sleep();
			}
			
			private static void sleep() {
				try {
					Thread.sleep(10000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		
		}
		
		class Thread1 extends Thread {
			private Resource res;
		
			public Thread1(Resource res) {
				this.res = res;
			}
		
			public void run() {
				res.methodOne("lockA");
			}
		}
		
		class Thread2 extends Thread {
			private Resource res;
		
			public Thread2(Resource res) {
				this.res = res;
			}
		
			public void run() {
				res.methodOne("lockA");
			}
		}
		
		public class TestMain {
			public static void main(String[] args) {
				Resource r1 = new Resource();
				//Resource r2 = new Resource();
				
				Thread1 t1 = new Thread1(r1);
				Thread2 t2 = new Thread2(r1);
		
				t1.start();
				t2.start();
			}
		}

上面一段简单的代码，分别来说明synchronized关键字加在代码片段中、加在方法声明上、加在静态方法声明上，它所使用的锁对象是哪些。
### synchronized关键字加在代码片段中
![](http://orxmumro7.bkt.clouddn.com/17-6-30/64548941.jpg)
Thread1和Thread2使用的是同一个锁对象（lockA）。
**字符串初始化时存放在方法区的字符串常量池。
"lockA"跟new String("lockA")，则是两个不同的对象。这里不做过多说明。**
Thread1和Thread2发生了互斥，说明**同步代码块的关键是synchronized关键字括号中的锁对象，可以是任意对象。**
![](http://orxmumro7.bkt.clouddn.com/17-6-30/33604190.jpg)
当锁对象不是同一对象时，synchronized代码块则不会发生互斥。
### synchronized关键字加在方法声明上
方法需要被对象调用，方法都有一个所属对象的引用，就是this。**同步方法使用的锁就是this锁。**
![](http://orxmumro7.bkt.clouddn.com/17-6-30/88196093.jpg)
再来看下面另两幅图。
![](http://orxmumro7.bkt.clouddn.com/17-6-30/54249445.jpg)
上图中，使用的是不同锁，所以没有发生互斥。
![](http://orxmumro7.bkt.clouddn.com/17-6-30/38169244.jpg)
当把res对象自己传递给methodOne()时，发现同步代码块跟同步方法开始互斥了。
#### 结论
**同步方法使用的锁就是this锁。**
### synchronized关键字加在静态方法声明上
再之前的对象初始化过程中提过，静态成员（**静态方法与静态属性，专业说话叫类变量**）和普通方法也会随着类的加载而被加载。this关键字表示一个对象引用。所以静态同步方法肯定不是用的this锁对象。
![](http://orxmumro7.bkt.clouddn.com/17-6-30/74972654.jpg)
运行，methodThree()发生了互斥。换种方式。
![](http://orxmumro7.bkt.clouddn.com/17-6-30/77421814.jpg)
methodOne()采用Resource的字节码对象作为锁对象。与methodThree()发生了互斥。
#### 结论
之前说过一个类只有一份字节码文件，在加载进内存时，一个类只有一个字节码文件对象。**静态同步方法使用的锁是该方法所在类的字节码文件对象。**（类名.class跟对象.getClass()是一码事，都是获取当前类的字节码对象）
### 死锁
* 原理：**同步中嵌套同步，彼此拿着需要的锁不放。**
			class Lock implements Runnable{
				private boolean flag;
				Lock(boolean flag){
					this.flag=flag;
				}
				public void run() {
					if(flag){
						synchronized (Mylock.locka) {
							System.out.println("if..locka");
							synchronized (Mylock.lockb) {
								System.out.println("if..lockb");
							}
						}
					} else{
						synchronized (Mylock.lockb) {
							System.out.println("else..lockb");
							synchronized (Mylock.locka) {
								System.out.println("else..locka");
							}
						}
					}
				}
			}
			class Mylock{
				static Object locka=new Object();
				static Object lockb=new Object();
			}
			public class Deadlock {
				public static void main(String[] args){
					Thread t1=new Thread(new Lock(true));
					Thread t2=new Thread(new Lock(false));
					t1.start();
					t2.start();
				}
			}
## Lock显示锁对象
		import java.util.concurrent.locks.Lock;
		import java.util.concurrent.locks.ReentrantLock;
		
		class Resource {
			private Lock lock = new ReentrantLock();
		
			public void set(String name) {
				lock.lock();
				try {
					System.out.println(System.currentTimeMillis() + "，"
							+ Thread.currentThread().getName() + "，" + name);
					try {
						Thread.sleep(10000);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				} finally {
					// 释放锁的操作一定要执行
					lock.unlock();
				}
			}
		}
		
		class Producer implements Runnable {
			private Resource res;
		
			public Producer(Resource res) {
				this.res = res;
			}
		
			public void run() {
				res.set("张三");
			}
		}
		
		class Consumer implements Runnable {
			private Resource res;
		
			public Consumer(Resource res) {
				this.res = res;
			}
		
			public void run() {
				res.set("李四");
			}
		}
		
		public class TestMain {
			public static void main(String[] args) {
				Resource r = new Resource();
		
				Producer pro = new Producer(r);
				Consumer con = new Consumer(r);
		
				Thread t1 = new Thread(pro);
				Thread t2 = new Thread(con);
		
				t1.start();
				t2.start();
			}
		}
### 运行一
![](http://orxmumro7.bkt.clouddn.com/17-6-30/93320041.jpg)
互斥，正常释放锁，正常运行。
### 运行二
![](http://orxmumro7.bkt.clouddn.com/17-6-30/47759812.jpg)
互斥，Thread-0未释放锁，Thread-1则一直阻塞。