package fun.redamancyxun.eqmaster.backend.service;

//import fun.redamancyxun.chinese.backend.controller.forum.request.ContactRequest;
import fun.redamancyxun.eqmaster.backend.controller.dailyshare.request.ContactRequest;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author Redamancy
 * @description 全局服务
 * @createDate 2024-04-03 22:39:04
 */
public interface GlobalService {

    // 上传图片
    String uploadImage(MultipartFile file);

    // 联系我们
    Boolean contact(ContactRequest contactRequest);
}
