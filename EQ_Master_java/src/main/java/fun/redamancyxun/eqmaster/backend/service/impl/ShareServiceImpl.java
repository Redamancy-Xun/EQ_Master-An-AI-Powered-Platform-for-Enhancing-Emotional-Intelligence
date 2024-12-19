package fun.redamancyxun.eqmaster.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import fun.redamancyxun.eqmaster.backend.entity.DailyShare;
import fun.redamancyxun.eqmaster.backend.entity.Share;
import fun.redamancyxun.eqmaster.backend.entity.Star;
import fun.redamancyxun.eqmaster.backend.exception.EnumExceptionType;
import fun.redamancyxun.eqmaster.backend.exception.MyException;
import fun.redamancyxun.eqmaster.backend.mapper.DailyShareMapper;
import fun.redamancyxun.eqmaster.backend.mapper.ShareMapper;
import fun.redamancyxun.eqmaster.backend.mapper.StarMapper;
import fun.redamancyxun.eqmaster.backend.service.LikeService;
import fun.redamancyxun.eqmaster.backend.service.ShareService;
import fun.redamancyxun.eqmaster.backend.service.UserService;
import fun.redamancyxun.eqmaster.backend.util.SessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

/**
 * @author Redamancy
 * @description 针对表【share（转发）】的服务接口实现
 * @createDate 2024-04-03 22:39:04
 */
@Service
public class ShareServiceImpl implements ShareService {

    @Autowired
    private DailyShareMapper dailyShareMapper;

    @Autowired
    private UserService userService;

    @Autowired
    private SessionUtils sessionUtils;

    @Autowired
    private LikeService likeService;

    @Autowired
    private ShareMapper shareMapper;

    /**
     * 转发每日分享
     * @param dailyShareId 每日分享id
     * @return 是否成功
     */
    @Override
    public Boolean shareDailyShare(String dailyShareId) {

        DailyShare dailyShare = dailyShareMapper.selectById(dailyShareId);
        if (dailyShare == null || dailyShare.getDeleteTime() != null) {
            throw new MyException(EnumExceptionType.DAILYSHARE_NOT_EXIST);
        }

        Share share = Share.builder()
                .dailyShareId(dailyShareId)
                .userId(sessionUtils.getUserId())
                .createTime(LocalDateTime.now())
                .deleteTime(null)
                .build();

        shareMapper.insert(share);

        dailyShare.setShare(dailyShare.getShare() + 1);
        if (dailyShareMapper.updateById(dailyShare) == 0){
            throw new MyException(EnumExceptionType.UPDATE_FAILED);
        }

        return true;
    }

    /**
     * 检查是否转发过
     * @param dailyShareId 每日分享id
     * @return 是否转发过
     */
    @Override
    public Boolean check(String dailyShareId, String userId) {
        DailyShare dailyShare = dailyShareMapper.selectById(dailyShareId);
        if (dailyShare == null || dailyShare.getDeleteTime() != null) {
            throw new MyException(EnumExceptionType.DAILYSHARE_NOT_EXIST);
        }

        QueryWrapper<Share> shareQueryWrapper = new QueryWrapper<>();
        shareQueryWrapper.eq("user_id", userId);
        shareQueryWrapper.eq("daily_share_id", dailyShareId);
        shareQueryWrapper.isNull("delete_time");

        return shareMapper.selectCount(shareQueryWrapper) != 0;
    }

}
