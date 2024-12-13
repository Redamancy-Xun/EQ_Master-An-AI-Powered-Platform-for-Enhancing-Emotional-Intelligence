package fun.redamancyxun.eqmaster.backend.util;

import cn.hutool.core.collection.CollUtil;
import com.github.pagehelper.Page;

import java.util.ArrayList;
import java.util.List;

public class PageUtils {

    /**
     * @param pageNum  页码
     * @param pageSize 每页数量
     * @param list     数据
     * 切割分页数据，手动制造分页
     */
    public static <T> List<T> splitList(int pageNum, int pageSize, List<T> list) {
        if (list.size() < (pageNum * pageSize)) {
            //如果数据不足一页，则返回空
            if(list.size() <= ((pageNum - 1) * pageSize)){
                return new ArrayList<>();
            }
            //如果正好页码数被数据数整除，此时最后一页数据为空，则返回上一页数据
            if (list.size() % pageSize == 0) {
                return list.subList((list.size() / pageSize - 1) * pageSize, list.size());
            }
            //如果不能整除，则返回最后一页不足一页的数据
            return list.subList(list.size() / pageSize * pageSize, list.size());
        }
        return list.subList((pageNum - 1) * pageSize, pageNum * pageSize);
    }

    /**
     * @param page     分页对象
     * @param pageNum  页码
     * @param pageSize 每页数量
     * @param list     数据
     * 设置分页信息
     */
    public static <T> List<T> setPage(Page<T> page, int pageNum, int pageSize, List<T> list) {
        if (CollUtil.isEmpty(list)) {
            page.setTotal(0);
            return list;
        }
        List<T> result = splitList(pageNum,pageSize,list);
        //设置分页数据
        int total = list.size();
        page.setTotal(total);
        return result;
    }

}
