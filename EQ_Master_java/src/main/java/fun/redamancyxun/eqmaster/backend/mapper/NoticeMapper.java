package fun.redamancyxun.eqmaster.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import fun.redamancyxun.eqmaster.backend.entity.Notice;
import org.apache.ibatis.annotations.Mapper;

/**
* @author Redamancy
* @description 针对表【notice（消息）】的数据库操作Mapper
* @createDate 2024-04-01 22:38:47
* @Entity com.ecnu_go.entity.Notice
*/
@Mapper
public interface NoticeMapper extends BaseMapper<Notice> {

}




