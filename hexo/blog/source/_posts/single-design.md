---
title: 单例设计模式
---
Java中有23种设计模式。设计模式是针对问题最有效的解决方法。
单例设计模式：解决一个类在内存中只存在一个对象。

## 实现步骤
1. 禁止其他的应用程序，通过此类来创建对象。私有化构造函数。
2. 在本类里面创建对象。
3. 为了其他应用程序能够访问本类对象，需要对外界提供一种访问方式。
## 饿汉式
		class Single {
			private static Single s = new Single();
		
			private Single() {
		
			}
		
			public static Single getInstance() {
				return s;
			}
		}
静态成员，随着类的加载而被加载。**该类在加载进内存时候，就已经初始化一个对象。**俗称：饿汉式。通过getInstance()即可获取该对象，并使用该对象。
## 懒汉式
		class Single {
			private static Single s = null;
		
			private Single() {
		
			}
		
			public static Single getInstance() {
				if (s == null) {
					synchronized (Single.class) {
						if (s == null) {
							s = new Single();
						}
					}
				}
				return s;
			}
		}
静态成员，随着类的加载而被加载。该类在加载进内存时候，对象还不存在。通过getInstance()获取该对象的时候才会初始化。那么这时就会出现线程安全问题。这里需要明确一点：**线程安全问题：只读不写没有该问题，有读有写就有该问题**。这也是饿汉式为什么没有线程安全问题的原因。
### synchronized代码块使用的锁，是该类的字节码对象锁。getInstance()在任何地方调用，都会发生互斥。
### getInstance()方法用了两个if判断，为什么不直接使用下面的代码呢？
			public static Single getInstance() {
				synchronized (Single.class) {
					s = new Single();
				}
				return s;
			}
* 多线程中每一个线程调用getInstance()都会发生互斥。
* 当有第一个线程进入到同步代码块创建一个对象的时候，刚走到return，互斥已经结束。第二个线程进入到同步代码块，这时又会创建一个对象。在内存中就会出现两个对象。
#### 结论
加双重if，同步效率较高一点。
## Java中的示例
### Runtime类，饿汉式
![](http://orxmumro7.bkt.clouddn.com/17-7-1/68605968.jpg)
### System类，懒汉式
![](http://orxmumro7.bkt.clouddn.com/17-7-1/76859891.jpg)

