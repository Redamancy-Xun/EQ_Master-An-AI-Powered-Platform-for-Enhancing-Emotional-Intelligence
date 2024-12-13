package fun.redamancyxun.eqmaster.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import fun.redamancyxun.eqmaster.backend.entity.DailyShare;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
* @author Redamancy
* @description 针对表【daily_share（发布的帖子）】的数据库操作Mapper
* @createDate 2024-04-01 22:39:02
* @Entity fun.redamancyxun.eqmaster.backend.entity.DailyShare
*/
@Mapper
public interface DailyShareMapper extends BaseMapper<DailyShare> {

    // 根据帖子热度（likes + comment + share + view + favorite）获取创建时间为三天内的帖子列表
    // create_time >= DATE_SUB(CURDATE() , INTERVAL 3 DAY) 表示创建时间为三天内
    @Select("SELECT * FROM daily_share WHERE delete_time is NULL " +
            "ORDER BY likes + comment_count + share + view + favorite DESC, create_time DESC")
    List<DailyShare> selectListByPopularity();

    // 根据文章内容关键词模糊搜索帖子
    @Select("SELECT * FROM daily_share " +
            "WHERE context LIKE CONCAT('%',#{keyword},'%') AND delete_time is NULL AND type = #{type}" +
            "ORDER BY likes + comment_count + share + view + favorite DESC, create_time DESC")
    List<DailyShare> selectListByKeyword(String keyword, String type);


//    // 根据用户id获取用户帖子列表
//    @Select("SELECT * FROM daily_share " +
//            "WHERE user_id = #{userId} AND delete_time is NULL " +
//            "ORDER BY top DESC, likes + comment + share + view + favorite DESC, create_time DESC")
//    List<DailyShare> selectListByUserId(String userId);
}




