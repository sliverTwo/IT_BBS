package com.sliver.common.utils;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

public class MailUtils {

	public static void sendMail(String email,String subject, String emailMsg)
			throws AddressException, MessagingException {
		// 1.创建一个程序与邮件服务器会话对象 Session

		Properties props = new Properties();
		//设置发送的协议
		props.setProperty("mail.transport.protocol", "SMTP");
		
		//设置发送邮件的服务器
//		props.setProperty("mail.host", "smtp.163.com");
		props.setProperty("mail.host", "127.0.0.1");
		props.setProperty("mail.smtp.auth", "true");// 指定验证为true

		// 创建验证器
		Authenticator auth = new Authenticator() {
			public PasswordAuthentication getPasswordAuthentication() {
				//设置发送人的帐号和密码
				return new PasswordAuthentication("Admin@sliver.com", "123456");
			}
		};

		Session session = Session.getInstance(props, auth);

		// 2.创建一个Message，它相当于是邮件内容
		Message message = new MimeMessage(session);

		//设置发送者
//		message.setFrom(new InternetAddress("18142611739@163.com"));
		message.setFrom(new InternetAddress("admin@sliver.com"));

		//设置发送方式与接收者
		message.setRecipient(RecipientType.TO, new InternetAddress(email)); 

		//设置邮件主题
		message.setSubject(subject);
//		message.setText("您好，此次验证码是:"+emailMsg+"，请及时激活。");

		//设置邮件内容
		message.setContent(emailMsg, "text/html;charset=utf-8");

		// 3.创建 Transport用于将邮件发送
		Transport.send(message);
	}
	public static void senMail(final String senderMail, final String senderPassWord ,
                               String receiverMail, String subject,
                               String emailMsg) throws MessagingException {
        // 1.创建一个程序与邮件服务器会话对象 Session

        Properties props = new Properties();
        //设置发送的协议
        props.setProperty("mail.transport.protocol", "SMTP");

        //设置发送邮件的服务器
//		props.setProperty("mail.host", "smtp.163.com");
        props.setProperty("mail.host", "127.0.0.1");
        props.setProperty("mail.smtp.auth", "true");// 指定验证为true

        // 创建验证器
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                //设置发送人的帐号和密码
                return new PasswordAuthentication(senderMail, senderPassWord);
            }
        };

        Session session = Session.getInstance(props, auth);

        // 2.创建一个Message，它相当于是邮件内容
        Message message = new MimeMessage(session);

        //设置发送者
//		message.setFrom(new InternetAddress("18142611739@163.com"));
        message.setFrom(new InternetAddress(senderMail));

        //设置发送方式与接收者
        message.setRecipient(RecipientType.TO, new InternetAddress(receiverMail));

        //设置邮件主题
        message.setSubject(subject);
//		message.setText("您好，此次验证码是:"+emailMsg+"，请及时激活。");

        //设置邮件内容
        message.setContent(emailMsg, "text/html;charset=utf-8");

        // 3.创建 Transport用于将邮件发送
        Transport.send(message);
    }
	public static void main(String[] args)
	{
		try
		{
			MailUtils.sendMail("t1@sliver.com", "测试邮件","测试邮件");
		} catch (MessagingException e)
		{
			e.printStackTrace();
		}
	}
}
