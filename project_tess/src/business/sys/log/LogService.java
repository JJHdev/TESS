package business.sys.log;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import commf.dao.CommonDAOImpl;
import common.base.BaseService;
import common.util.paging.PaginatedArrayList;

@Service
@SuppressWarnings({"rawtypes"})
public class LogService extends BaseService {

    @Autowired
    private CommonDAOImpl dao;
    
    //++++++++++++++++++++++++++++++++++++++
    //메뉴별 접속통계
    //++++++++++++++++++++++++++++++++++++++
    public List listLogAccMenu(Map reqMap) {
        List list = null;
        list = dao.list("Log.listLogAccMenu", reqMap);
        return list;
    }

    public PaginatedArrayList listLogAccMenu(Map reqMap, int currPage, int pageSize) {
        PaginatedArrayList list = dao.pageList("Log.listLogAccMenu", reqMap, currPage, pageSize);
        return list;
    }
    
    //++++++++++++++++++++++++++++++++++++++
    //사용자 접속통계
    //++++++++++++++++++++++++++++++++++++++
    public List listLogAccUser(Map reqMap) {
        List list = null;
        list = dao.list("Log.listLogAccUser", reqMap);
        return list;
    }
    
    public PaginatedArrayList listLogAccUser(Map reqMap, int currPage, int pageSize) {
        PaginatedArrayList list = dao.pageList("Log.listLogAccUser", reqMap, currPage, pageSize);
        return list;
    }
}