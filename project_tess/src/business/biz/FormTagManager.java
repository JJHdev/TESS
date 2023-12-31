package business.biz;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.LinkedMap;

import business.biz.comm.domain.ComboDomain;

import commf.message.Message;
import common.util.CommUtils;

@SuppressWarnings({"rawtypes","unchecked"})
public class FormTagManager {


	// ComboList Create (Map)
	public static Map listToMapCombo(List list, String type, String allFlag) {
		Map map = new LinkedMap();

		// 전체 표시
		if (CommUtils.nvlTrim(allFlag).equalsIgnoreCase("Y"))
			map.put(Message.getMessage("prompt.comboValueAll"), Message.getMessage("prompt.comboTextAll"));
		else if (CommUtils.nvlTrim(allFlag).equalsIgnoreCase("NULL"))
			map.put("", Message.getMessage("prompt.comboTextAll"));
		else
			if (!CommUtils.nvlTrim(allFlag).equalsIgnoreCase("N")) map.put("", allFlag);


		if (type.equalsIgnoreCase("roleList")) {
            if (list != null && list.size() > 0) {
                for (int i = 0; i < list.size(); i++) {
                    HashMap dataMap = (HashMap)list.get(i);
                    map.put(dataMap.get("roleId"), dataMap.get("roleId")+" - "+dataMap.get("roleNm"));
                }
            }
		// CODE Table 에서 조회한 데이터 처리...
		} else {
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					HashMap dataMap = (HashMap)list.get(i);
					map.put(dataMap.get("code"), dataMap.get("codeNm"));
				}
			}
		}
		return map;
	}

	// ComboList Create (Map)
	public static Map listToMapCombo(List list, String type, String code, String codeNm, String allFlag) {
		Map map = new LinkedMap();

		// 전체 표시
		if (CommUtils.nvlTrim(allFlag).equalsIgnoreCase("Y"))
			map.put(Message.getMessage("prompt.comboValueAll"), Message.getMessage("prompt.comboTextAll"));
		else if (CommUtils.nvlTrim(allFlag).equalsIgnoreCase("NULL"))
			map.put("", Message.getMessage("prompt.comboTextAll"));
		else
			if (!CommUtils.nvlTrim(allFlag).equalsIgnoreCase("N")) map.put("", allFlag);


		if (type.equalsIgnoreCase("")) {

		if(CommUtils.nvlTrim(code).equals(""))   code = "code";
		if(CommUtils.nvlTrim(codeNm).equals("")) codeNm = "codeNm";

		// CODE Table 에서 조회한 데이터 처리...
		} else {
			if (list != null && list.size() > 0) {
				for (int i = 0; i < list.size(); i++) {
					HashMap dataMap = (HashMap)list.get(i);
					map.put(dataMap.get(code), dataMap.get(codeNm));
				}
			}
		}
		return map;
	}

	// ComboList Create (Model)
	public static Map listToModelCombo(List list, String name, String allFlag) {

		Map map = new LinkedMap();

		// 전체 표시
		if (CommUtils.nvlTrim(allFlag).equalsIgnoreCase("Y"))
			map.put(Message.getMessage("prompt.comboValueAll"), Message.getMessage("prompt.comboTextAll"));
		else if (CommUtils.nvlTrim(allFlag).equalsIgnoreCase("NULL"))
			map.put("", Message.getMessage("prompt.comboTextAll"));
		else
			if (!CommUtils.nvlTrim(allFlag).equalsIgnoreCase("N")) map.put("", allFlag);

		if (list != null && list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				ComboDomain model = (ComboDomain) list.get(i);
				map.put(model.getComboValue(), model.getComboText());
			}
		}

		return map;
	}

	/**
	 *
	 * @param list
	 * @param allFlag
	 * @return
	 */
	public static List listToListCombo(List list, String allFlag) {

	    List rtnLst = new ArrayList();
	    Map lst0 = new HashMap();
	    String allText = "";
	    // 전체 표시
        if (CommUtils.nvlTrim(allFlag).equalsIgnoreCase("S"))
            allText = Message.getMessage("prompt.comboTextSel");
        else if (CommUtils.nvlTrim(allFlag).equalsIgnoreCase("A"))
            allText = Message.getMessage("prompt.comboTextAll");
        else
            allText = allFlag;

        lst0.put("code", "");
        lst0.put("codeNm", allText);

        rtnLst.add(lst0);

	    if (list != null && list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                HashMap dataMap = (HashMap)list.get(i);
                Map comb = new HashMap();
                comb.put("code", dataMap.get("code"));
                comb.put("codeNm", dataMap.get("codeNm"));
                comb.put("pCode", dataMap.get("pCode"));

                rtnLst.add(comb);
            }
        }

	    return rtnLst;
	}

}



