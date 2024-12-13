package fun.redamancyxun.eqmaster.backend.util;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.mail.internet.MimeMessage;
import java.io.File;
import java.sql.Timestamp;
import java.util.List;

import static fun.redamancyxun.eqmaster.backend.common.CommonConstants.IMAGE_PATH;
import static fun.redamancyxun.eqmaster.backend.common.CommonConstants.USER_FILE_PATH;

@Component
public class MessageUtil {

  //注册账号
  //生成注册账号时发送的验证邮件内容
  public String signUp(String email, String code) {
    String htmlContent = "<!DOCTYPE html>\n" +
                         "<html>\n" +
                         "  <head>\n" +
                         "    <title>验证码邮件</title>\n" +
                         "  </head>\n" +
                         "  <body style=\"font-family: Arial; color: #333333\">\n" +
                         "    <div\n" +
                         "      style=\"\n" +
                         "        max-width: 600px;\n" +
                         "        margin: 0 auto;\n" +
                         "        background-color: #ffffff;\n" +
                         "        padding: 20px;\n" +
                         "      \"\n" +
                         "    >\n" +
                         "      <h2 style=\"color: #b70031\">您好，<span style=\"font-size: 16px;\">%s</span></h2>\n" +
                         "      <p>\n" +
                         "        您于 %s 尝试验证此邮箱地址，验证码为：<span style=\"font-size: 24px; color: #b70031; font-weight: 700\">%s</span>\n" +
                         "      </p>\n" +
                         "      <p>请输入此验证码完成操作，验证码15分钟内有效。</p>\n" +
                         "      <p style=\"font-size: 14px; color: #888888; margin-top: 20px\">\n" +
                         "        如果您没有进行相关操作，请忽略此邮件。<br />\n" +
                         "        感谢您的使用!\n" +
                         "      </p>\n" +
                         "    </div>\n" +
                         "  </body>\n" +
                         "</html>";
    return String.format(htmlContent, email, getNowTime(), code);
  }

  /**
   * @param type 0:系统 1:给帖子点赞 2:给帖子回复 3:给评论点赞 4:给评论回复 5:给回复点赞 6:给回复回复
   * @return 返回消息内容
   */
//根据消息类型生成相应的通知消息内容
  public static String getNoticeMessage(String sender, Integer type, String content) {
    String result;
    switch (type) {
      case 0:
        result = "有新的系统消息";
        break;
      case 1:
      case 3:
      case 5:
        result = "收到点赞";
        break;
      case 2:
      case 4:
      case 6:
        result = content;
        break;
      default:
        result = "有新消息";
        break;
    }
    return result;
  }

  // 获取现在的时间
  private static String getNowTime() {
    Timestamp timestamp = new Timestamp(System.currentTimeMillis());
    return timestamp
        .toString()
        .substring(0, timestamp.toString().indexOf("."));
  }

  //发送邮件。该方法通过 Spring 的 JavaMailSender 发送邮件，设置发件人、收件人、标题、内容，并可以添加附件。
  public void sendMail(String sender, String email, String title, String content, List<String> attachments, JavaMailSender jms) throws Exception {

    //调用 jms.createMimeMessage() 方法创建一个 MimeMessage 对象 mainMessage，用于构建邮件消息
    MimeMessage mainMessage = jms.createMimeMessage();

    //通过 MimeMessageHelper 对象 helper 对邮件消息进行设置
    MimeMessageHelper helper = new MimeMessageHelper(mainMessage, true);

    //设置发件人的邮箱地址
    helper.setFrom(sender);

    //设置收件人的邮箱地址
    helper.setTo(email);

    //设置邮件的标题
    helper.setSubject(title);

    //设置邮件的内容，第二个参数 true 表示内容为 HTML 格式
    helper.setText(content, true);

    if (attachments != null && !attachments.isEmpty()) {
      for (String attachment : attachments) {
        //对附件路径进行处理，将 IMAGE_PATH 替换为 USER_FILE_PATH，得到真实的文件路径
        attachment = attachment.replace(IMAGE_PATH, USER_FILE_PATH);
        //通过附件路径创建一个 File 对象，获取附件的文件名 fileName
        String fileName = attachment.substring(attachment.lastIndexOf(File.separator) + 1);
        //调用 helper.addAttachment 方法将附件添加到邮件中，参数为附件的文件名和 File 对象
        helper.addAttachment(fileName, new File(attachment));
      }
    }

    //调用 jms.send 方法发送构建好的邮件消息 mainMessage
    jms.send(mainMessage);
  }
}
