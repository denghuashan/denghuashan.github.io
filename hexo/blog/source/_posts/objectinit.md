---
title: Java对象初始化的过程
---
从学Java开始，就一直牢牢的记住着一句话。"基础决定了你在这条道路上能走多远。"，虽然当时不是很明白。但庆幸的是一直都放在心里。再温习一下Java对象初始化的过程，把这种理解性的知识，用图文的方式去描述出来。

## 一个很简单的Java类
	    public class Student {
	    
	    	private String name = "haha";
			private int age;
			private static String country = "cn";
			
			//无参构造函数
			Student() {
			}
			
			//有参构造函数
			Student(String name, int age) {
				System.out.println("有参构造函数：" + name + ".." + age);
				this.name = name;
				this.age = age;
			}
			
			//构造代码块
			{
				System.out.println("构造代码块：" + name + ".." + age);
			}
			
			//静态代码块
			static {
				System.out.println("静态代码块：static..");
			}
			
			public void setName(String name) {
				this.name = name;
			}
		
			public void speak() {
				System.out.println(this.name + "..." + this.age);
			}
			
			public void listen() {
				speak();
			}
			
			public static void showCountry() {
				System.out.println("country=" + country);
				method();
			}
		
			public static void method() {
				System.out.println("method run");
			}
	    }
## Student s = new Student("zhangsan", 19);
![](http://orxmumro7.bkt.clouddn.com/17-6-29/82172780.jpg)
上图中，在我们使用的时候，该句话都做了什么事情？（只谈论内存中的堆、栈区域，不涉及其他区域）
![](http://orxmumro7.bkt.clouddn.com/17-6-29/54828942.jpg)
## 文字结论
1. 当虚拟机读取到这句话的时候，首先看等号的左边。Student s，s是一个变量，虚拟机会在栈内存中开辟空间，存放s这个变量。
2. 当读取到等号的右边new Student("zhangsan", 19)。因为用到了Student类，虚拟机会编译Student.java文件，生成Student.class文件。俗称字节码文件，一个类只有一份字节码文件。（请自行区别.java文件跟类的概念）
3. 会把Student这个类的字节码从硬盘加载进内存。这里提一嘴，JVM中的类加载器Classloader。
4. 如果有静态代码块，就会随着类的加载而执行。静态成员（静态方法与静态属性，专业说话叫类变量）和普通方法也会随着类的加载而被加载。
5. 在堆内存中开辟空间，并分配内存地址。（内存地址是十六进制数）
6. 在堆内存中建立对象特有属性，并同时对特有属性进行默认初始化。
7. 对对象属性进行显示初始化。
8. 执行构造代码块，对所有对象进行初始化。
9. 执行对应的构造函数，对对象进行初始化。
10. 将内存地址赋给栈内存中的s变量。（栈内存中的变量指向堆内存中的变量，这就是Java中的指针）
## 静态成员
存放在方法区，在内存中只有一份。随着类的的加载而被加载，优先于对象存在，被所有的对象所共享，可以被类名直接调用，也可以被对象调用。
![](http://orxmumro7.bkt.clouddn.com/17-6-29/87231977.jpg)
showCountry()方法中调用method()，就是直接省略了（Student.）
同样的，listen()方法中调用speak()，就是直接省略了（this.）
## 如理解的描述有错，请务必告知。谢谢！
对JVM感兴趣的，可以膜拜《深入理解Java虚拟机》一书。

