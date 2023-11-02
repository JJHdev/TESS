package common.file;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import common.util.CommUtils;
import common.util.FileUtil;
import common.util.properties.ApplicationProperty;

/**
 * Program Name    : File Manager
 * Description     : Common File Management
 * Programmer Name : ntarget
 * svn ID          : ntarget
 * Creation Date   : 2014-06-09
 * Used Table      :
 */

@SuppressWarnings({"rawtypes", "unchecked"})
public class FileManager {

	//private final Log logger = LogFactory.getLog(getClass());
	protected final Logger logger = LoggerFactory.getLogger(getClass());

	/**
	 * File upload (Normal)
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@RequestMapping
	public List multiFileUpload(HttpServletRequest request) throws IOException {
	    // 빈 file정보는 포함하지 않고 리턴.
	    return multiFileUploadDetail(request, false);
	}
	
	/**
	 * 관광사업관리에서 사용할 목적으로 생성.
	 *     - 빈 파일 객체를 호함하여 리스트를 리턴한다.
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@RequestMapping
	public List multiFileUploadEvalu(HttpServletRequest request) throws IOException {
	    // 빈 file정보는 포함하지 않고 리턴.
	    return multiFileUploadDetail(request, true);
	}
	
	@RequestMapping
	public List multiFileUploadEvalu02(HttpServletRequest request) throws IOException {
	    // 빈 file정보는 포함하지 않고 리턴.
	    return multiFileUploadDetail02(request, true);
	}
	
	
	/**
	 * File upload 상세(필요한 option 정보를 늘려서 사용하는 용도로...)
	 * @param request
	 * @param isInsertEmptyFileInfo    리스트 객체를 생성할 때 빈 file객체 정보를 포함할지 여부
	 * @return
	 * @throws IOException
	 */
    @RequestMapping
    private List multiFileUploadDetail(HttpServletRequest request, boolean isInsertEmptyFileInfo) throws IOException {

        List listFile = new ArrayList();
        
        if (-1 >= request.getContentType().indexOf("multipart/form-data")) {
            return null;
        }

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> files = multipartRequest.getFileMap();

        String tempDir = ApplicationProperty.get("upload.temp.dir");

        logger.debug("File Directory Create !!!");

        FileUtil.makeDirectories(tempDir);

        for (int i = 0; i < files.size(); i++) {

            String upfileName = "upfile" + i;
            MultipartFile inFile = files.get(upfileName);

            String saveFileName = getFileName(tempDir, inFile.getOriginalFilename());

            try {
                logger.debug("File Upload !!!");

                if (!saveFileName.equals("")) {
                    FileUtil.copyFile(inFile.getInputStream(), new FileOutputStream(tempDir + saveFileName));

                    HashMap fmap = new HashMap();
                    fmap.put("fileSvrNm", saveFileName);
                    fmap.put("fileOrgNm", CommUtils.nvlTrim(inFile.getOriginalFilename()) );
                    fmap.put("tempDir"  , tempDir);
                    fmap.put("fileSize" , inFile.getSize());
                    fmap.put("idx"      , String.valueOf(i));

                    listFile.add(fmap);
                }
                else {
                    // isInsertEmptyFileInfo이 true이면 빈 파일정보를 empty hashmap으로 추가.
                    if(isInsertEmptyFileInfo) {
                        listFile.add(new HashMap());
                    }
                }
            } catch (FileNotFoundException e) {
                throw new RuntimeException(e);
            } catch (IOException e) {
                throw new RuntimeException(e);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }

        }

        logger.debug("File Upload End !!!");

        return listFile;
    }
    
    
    /**
	 * File upload 상세(필요한 option 정보를 늘려서 사용하는 용도로...)
	 * @param request
	 * @param isInsertEmptyFileInfo    리스트 객체를 생성할 때 빈 file객체 정보를 포함할지 여부
	 * @return
	 * @throws IOException
	 */
    @RequestMapping
    private List multiFileUploadDetail02(HttpServletRequest request, boolean isInsertEmptyFileInfo) throws IOException {

        List listFile = new ArrayList();
        
        if (-1 >= request.getContentType().indexOf("multipart/form-data")) {
            return null;
        }

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> files = multipartRequest.getFileMap();

        String tempDir = ApplicationProperty.get("upload.temp.dir");

        logger.debug("File Directory Create !!!");

        FileUtil.makeDirectories(tempDir);

        String upfileName = "upfile0";
        MultipartFile inFile = files.get(upfileName);

        String saveFileName = getFileName(tempDir, inFile.getOriginalFilename());

        try {
            logger.debug("File Upload !!!");

            if (!saveFileName.equals("")) {
                FileUtil.copyFile(inFile.getInputStream(), new FileOutputStream(tempDir + saveFileName));

                HashMap fmap = new HashMap();
                fmap.put("fileSvrNm", saveFileName);
                fmap.put("fileOrgNm", CommUtils.nvlTrim(inFile.getOriginalFilename()) );
                fmap.put("tempDir"  , tempDir);
                fmap.put("fileSize" , inFile.getSize());
                fmap.put("idx"      , String.valueOf(0));

                listFile.add(fmap);
            }
            else {
                // isInsertEmptyFileInfo이 true이면 빈 파일정보를 empty hashmap으로 추가.
                if(isInsertEmptyFileInfo) {
                    listFile.add(new HashMap());
                }
            }
        } catch (FileNotFoundException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }


        logger.debug("File Upload End !!!");

        return listFile;
    }


	/**
	 * File Upload
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws Exception
	 */
	public Map makeFileMap(HttpServletRequest request, HttpServletResponse response) throws FileNotFoundException, IOException {
		Map fmap = new HashMap();

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> files = multipartRequest.getFileMap();

		String excelDir = ApplicationProperty.get("upload.excel.dir");

		logger.debug("File Directory Create !!!");

		FileUtil.makeDirectories(excelDir);

		String upfileName = "upfile1";
		MultipartFile inFile = files.get(upfileName);

		String saveFileName = getFileName(excelDir, inFile.getOriginalFilename());

		try {
			FileUtil.copyFile(inFile.getInputStream(), new FileOutputStream(excelDir + saveFileName));

			fmap.put("inFile", inFile.getInputStream());
			fmap.put(upfileName, saveFileName);
			fmap.put("excelDir", excelDir);

		} catch (FileNotFoundException e) {
			throw new RuntimeException(e);
		} catch (IOException e) {
			throw new RuntimeException(e);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

		return fmap;
	}

	/**
	 * @param dir
	 * @param originalFileName
	 * @return
	 * @author purple
	 */
	public String getFileName(String dir, String originalFileName) {
		if (CommUtils.nvlTrim(originalFileName).equals(""))
			return "";

		String dotextension = originalFileName.substring(originalFileName.lastIndexOf("."));
		java.io.File currentPath = new java.io.File(dir);
		String[] fileList = null;

		Random random = new Random(System.currentTimeMillis());
		FileNameFilter fileNameFilter = new FileNameFilter();

		StringBuffer sb = null;
		do {
			sb = new StringBuffer();
			sb.append(String.valueOf(System.currentTimeMillis()));
			sb.append(String.valueOf(random.nextLong()));
			sb.append(dotextension);
			fileNameFilter.setFileName(sb.toString());

			fileList = currentPath.list(fileNameFilter);
		} while (fileList.length > 0);

		return sb.toString();
	}

	/**
	 * @author purple
	 */
	static class FileNameFilter implements FilenameFilter {
		String sFileName = null;

		public void setFileName(String sFileName) {
			this.sFileName = sFileName;
		}

		public boolean accept(java.io.File directory, String name) {
			if (name.equals(sFileName)) {
				return true;
			}
			return false;
		}
	}
}

