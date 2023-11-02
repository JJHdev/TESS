package business.biz;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.ibatis.SqlMapClientCallback;

import com.ibatis.sqlmap.client.SqlMapExecutor;
import commf.dao.CommonDAOImpl;
import commf.exception.BusinessException;
import common.base.BaseService;
import common.user.UserInfo;
import common.util.CommUtils;
import common.util.FileUtil;

/**
 * Program Name    : ExcelService
 * Description     : Excel Upload Common Service
 * Programmer Name : ntarget
 * svn ID          : ntarget
 * Creation Date   : 2010-03-03 ( Excel Common Addition )
 * Used Table      :
 */

@SuppressWarnings({"rawtypes","unchecked"})
public class ExcelService extends BaseService {

	private final String LOG_FILE_NAME	= "ImportExcel.log";
	private final int LIST_LIMIT = 100;		// DB등록처리 Group 구분

	@Autowired
	private CommonDAOImpl dao;

	@Autowired
	private UserInfo userInfo;

	/**
	 * EXCEL SERVICE
	 * @throws IOException
	 * @throws FileNotFoundException
	 */
	@SuppressWarnings("deprecation")
	public long regiExcelLoadImport(Map reqMap, Map fileMap, String updateName, String insertName, String[] colName, String batch)
	throws Exception, FileNotFoundException, IOException {

		long loopcnt = 0;
		List listLoadData	= new ArrayList();
		//String[] colName = FileManager.getColumnInfo(method);

		if (colName == null || colName.length == 0)
			throw processException("정의된 Column정보가 없습니다. 확인바랍니다.[FileManager.getColumnInfo]");

		String filePath = (String)fileMap.get("excelDir");
		String fileName = (String)fileMap.get("upfile1");

		POIFSFileSystem filesystem = new POIFSFileSystem(new FileInputStream(filePath+ "/" +fileName));
        HSSFWorkbook workbook = new HSSFWorkbook(filesystem);

        HSSFSheet sheet = null;
        HSSFRow row     = null;
        HSSFCell cell   = null;

        // 생성된 시트 수만큼..
        int sheetNum	= workbook.getNumberOfSheets();

        // LOG
        CommUtils.logWrite("", LOG_FILE_NAME);
        CommUtils.logWrite("Excel Upload Start ----- [exclUploadCodeMgmt] ", LOG_FILE_NAME);

        int totInsertCnt = 0;
        int totUpdateCnt = 0;
        for (int i = 0; i < sheetNum; i++) {
        	CommUtils.logWrite("Sheet Num : "+ i, LOG_FILE_NAME);
        	CommUtils.logWrite("Sheet Name : "+ workbook.getSheetName(i), LOG_FILE_NAME);

        	sheet = workbook.getSheetAt(i);
        	// 생성된 시트를 이용하여 그 행의 수만큼
        	int rows = sheet.getPhysicalNumberOfRows();

        	CommUtils.logWrite("Row Total Num : "+ (rows-1), LOG_FILE_NAME);

        	for (int r = 0; r < rows; r++) {
            	if (r == 0) continue;	// Head Line 은 Skip

        		row	= sheet.getRow(r);

        		Map cellMap	= new HashMap(reqMap);

        		// 생성된 Row를 이용하여 그 셀의 수만큼
        		int cells = row.getPhysicalNumberOfCells();

        		if (cells != colName.length)
        			throw new BusinessException("Excel 데이터 포맷이 맞지 않습니다. 확인바랍니다.");

        		for (short c = 0; c < cells; c++) {	// short형. 255개 Max
        			cell = row.getCell(c);

					if (colName != null) {
						switch (cell.getCellType()) {
						case HSSFCell.CELL_TYPE_NUMERIC:
							cellMap.put(colName[c], cell.getNumericCellValue());
							break;
						case HSSFCell.CELL_TYPE_STRING:
							cellMap.put(colName[c], cell.getStringCellValue());
							break;
						}
					}
        		}

        		listLoadData.add(cellMap);

        		// 저장
        		// out of memory 때문에 짤라서 처리하는게 좋음.
        		int icnt = 0;
        		int ucnt = 0;

        		if (listLoadData.size() == LIST_LIMIT || r == rows-1) {
        			if (CommUtils.nvlTrim(batch).equalsIgnoreCase("Y")) {
    					int batchCnt = regiBatch(listLoadData, insertName);
    					if (batchCnt == 0)
    						throw processException("ERROR] 데이터가 정상적으로 저장되지 않았습니다. [regiExcelLoadImport]");

    					CommUtils.logWrite("Saving Count : "+ listLoadData.size()+" [Insert : "+batchCnt+"]", LOG_FILE_NAME);
        			} else {
	        			for (int n = 0; n < listLoadData.size(); n++) {
	        				Map importMap = (HashMap)listLoadData.get(n);
	        				importMap.put("gsUserId", userInfo.getUserId());

	        				if (updateName != null) {
	            				if (dao.update(updateName, importMap) == 0) {
	            					// Insert
	            					icnt += dao.update(insertName, importMap);
	            				}
	        				} else {
	        					// Insert
	        					icnt += dao.update(insertName, importMap);
	        				}
	        			}
	        			CommUtils.logWrite("Saving Count : "+ listLoadData.size()+" [Insert : "+icnt+", Update : "+ucnt+"]", LOG_FILE_NAME);

        			}
        			listLoadData.clear();
        		}
				totInsertCnt+=icnt;
				totUpdateCnt+=ucnt;

        		loopcnt++;
        	}
        }

        CommUtils.logWrite("Total Count (Insert, Update) : "+totInsertCnt+", "+totUpdateCnt, LOG_FILE_NAME);
        CommUtils.logWrite("Excel Upload End ----- [exclUploadCodeMgmt] ", LOG_FILE_NAME);
        CommUtils.logWrite("", LOG_FILE_NAME);

    	// 처리 후 파일 삭제.
		FileUtil.deleteFile(filePath +"/"+ fileName);

		return loopcnt;
	}

	/**
	 * EXCEL SERVICE
	 * @throws IOException
	 * @throws FileNotFoundException
	 */
	@SuppressWarnings({ "deprecation", "unused" })
	public List listExcelLoad(Map reqMap, Map fileMap, String[] colName)
	throws Exception, FileNotFoundException, IOException {

		long loopcnt = 0;
		List listLoadData	= new ArrayList();
		//String[] colName = FileManager.getColumnInfo(method);

		if (colName == null || colName.length == 0)
			throw processException("정의된 Column정보가 없습니다. 확인바랍니다.[FileManager.getColumnInfo]");

		String filePath = (String)fileMap.get("excelDir");
		String fileName = (String)fileMap.get("upfile1");

		POIFSFileSystem filesystem = new POIFSFileSystem(new FileInputStream(filePath+ "/" +fileName));
		HSSFWorkbook workbook = new HSSFWorkbook(filesystem);

		HSSFSheet sheet = null;
		HSSFRow row     = null;
		HSSFCell cell   = null;

		// 생성된 시트 수만큼..
		int sheetNum	= workbook.getNumberOfSheets();

		// LOG
		CommUtils.logWrite("", LOG_FILE_NAME);
		CommUtils.logWrite("Excel Upload Start ----- [listExcelLoad] ", LOG_FILE_NAME);

		for (int i = 0; i < sheetNum; i++) {
			CommUtils.logWrite("Sheet Num : "+ i, LOG_FILE_NAME);
			CommUtils.logWrite("Sheet Name : "+ workbook.getSheetName(i), LOG_FILE_NAME);

			sheet = workbook.getSheetAt(i);
			// 생성된 시트를 이용하여 그 행의 수만큼
			int rows = sheet.getPhysicalNumberOfRows();

			CommUtils.logWrite("Row Total Num : "+ (rows-1), LOG_FILE_NAME);

			for (int r = 0; r < rows; r++) {
				if (r == 0) continue;	// Head Line 은 Skip

				row	= sheet.getRow(r);

				Map cellMap	= new HashMap();
				// 생성된 Row를 이용하여 그 셀의 수만큼
				int cells = row.getPhysicalNumberOfCells();

				if (cells != colName.length)
					throw processException("Excel 데이터 포맷이 맞지 않습니다. 확인바랍니다.");

				for (short c = 0; c < cells; c++) {	// short형. 255개 Max
					cell = row.getCell(c);

					if (colName != null) {
						switch (cell.getCellType()) {
						case HSSFCell.CELL_TYPE_NUMERIC:
							cellMap.put(colName[c], cell.getNumericCellValue());
							break;
						case HSSFCell.CELL_TYPE_STRING:
							cellMap.put(colName[c], cell.getStringCellValue());
							break;
						}
					}
				}

				listLoadData.add(cellMap);

				loopcnt++;
			}
		}

		CommUtils.logWrite("Excel Upload End ----- [listExcelLoad] ", LOG_FILE_NAME);
		CommUtils.logWrite("", LOG_FILE_NAME);

		// 처리 후 파일 삭제.
		FileUtil.deleteFile(filePath +"/"+ fileName);

		return listLoadData;
	}

	// SMS_SEND_LOG Batch INSERT
	public int regiBatch(final List smsList, final String statment) {
		try {
			dao.batch(new SqlMapClientCallback(){
				public Object doInSqlMapClient(SqlMapExecutor executor) throws SQLException{
					executor.startBatch();
					for ( int i = 0 ; i < smsList.size() ; i++ ) {
						executor.insert(statment, smsList.get(i));
					}
					executor.executeBatch();
					return null;
				}
			});
			return 1;
		} catch(Exception ex) {
			return 0;
		}
	}
}
