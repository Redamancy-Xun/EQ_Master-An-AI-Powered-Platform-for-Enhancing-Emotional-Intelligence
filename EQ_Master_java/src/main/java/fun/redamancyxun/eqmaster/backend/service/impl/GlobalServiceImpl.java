package fun.redamancyxun.eqmaster.backend.service.impl;

import cn.hutool.core.io.FileUtil;
import cn.hutool.core.util.IdUtil;
//import fun.redamancyxun.eqmaster.backend.controller.forum.request.ContactRequest;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.request.ContactRequest;
import fun.redamancyxun.eqmaster.backend.entity.User;
import fun.redamancyxun.eqmaster.backend.exception.EnumExceptionType;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.service.GlobalService;
import fun.redamancyxun.eqmaster.backend.service.UserService;
import fun.redamancyxun.eqmaster.backend.util.ImageUtil;
import fun.redamancyxun.eqmaster.backend.util.MessageUtil;
import fun.redamancyxun.eqmaster.backend.util.SessionUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

import static fun.redamancyxun.eqmaster.backend.common.CommonConstants.IMAGE_PATH;
import static fun.redamancyxun.eqmaster.backend.common.CommonConstants.USER_FILE_PATH;

/**
 * @author Redamancy
 * @description 全局服务
 * @createDate 2024-04-03 22:39:04
 */
@Service
@Slf4j
public class GlobalServiceImpl implements GlobalService {

    @Autowired
    private SessionUtils sessionUtils;

    @Autowired
    private JavaMailSender jms;

    @Autowired
    private MessageUtil messageUtil;

    @Autowired
    private UserService userService;

    @Value("${spring.mail.username}")
    private String sender;

    /**
     * 上传图片
     * @param file 图片文件
     * @return 图片路径
     * @throws MyException 通用异常
     */
    @Override
    public String uploadImage(MultipartFile file) throws MyException {
        //获取文件的原始文件名
        String original = file.getOriginalFilename();
        //生成一个随机的唯一标识符，在文件路径中使用，以确保每个上传的文件都有一个唯一的路径
        String flag = IdUtil.fastSimpleUUID();
        //构建上传文件的存储路径
        String rootFilePath = USER_FILE_PATH + flag + "-" + original;
        try {
            //使用 FileUtil 工具类的 writeBytes 方法将文件数据写入磁盘上的指定路径 rootFilePath
            FileUtil.writeBytes(file.getBytes(), rootFilePath);
            //刚刚上传的文件
            File image = new File(rootFilePath);
            if (image.length() >= 1024 * 1024 / 10) {
                while (image.length() >= 1024 * 1024 / 10) {
                    //调用 ImageUtil 工具类的 scale 方法对图片进行缩放。缩放后的图片将覆盖原有文件，并且缩放比例为 2
                    ImageUtil.scale(rootFilePath, rootFilePath,2,false);
                }
            }
        } catch (IOException e) {
            throw new MyException(EnumExceptionType.READ_FILE_ERROR);
        }
        return IMAGE_PATH + flag + "-" + original;
    }

    /**
     * 联系我们
     * @param contactRequest 联系我们请求
     * @return 是否成功
     * @throws MyException 通用异常
     */
    @Override
    public Boolean contact(ContactRequest contactRequest) throws MyException{
        try {
            User user = userService.getUserById(sessionUtils.getUserId());
            messageUtil.sendMail(sender, sender,"Bug report from:" + user.getUsername(),
                    contactRequest.getContent(), contactRequest.getImages(), jms);
        } catch (Exception e) {
            if (e instanceof MyException) {
                throw (MyException)e;
            }
            e.printStackTrace();
            throw new MyException(EnumExceptionType.SEND_EMAIL_FAILED);
        }

        return true;
    }

}





