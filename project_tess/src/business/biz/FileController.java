package business.biz;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import common.base.BaseController;
import common.file.FileManager;
import common.util.CommUtils;
import common.util.FileUtil;
import common.util.properties.ApplicationProperty;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;

/**
 * Program Name    : FileController
 * Description     : Common File Management
 * Programmer Name : ntarget
 * Creation Date   : 2010-02-05
 * Used Table      :
 */

@Controller
@SuppressWarnings({ "rawtypes","unchecked","unused" })
public class FileController extends BaseController {

	@Resource(name="fileManager")
	FileManager fileManager;

	@Autowired
	FileService fileService;


	/**
	 * File Upload
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping("/comm/fileUpload.do")
	public void fileUpload(HttpServletRequest request, HttpServletResponse response) throws IOException {
		List listFile = new ArrayList();

		// 파일 멀티로 받음
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> files = multipartRequest.getFileMap();

		String tempDir = ApplicationProperty.get("upload.temp.dir");

		//디렉토리 생성
		FileUtil.makeDirectories(tempDir);

		// 파일이름이 중복되면 spring에서 에러가 나므로 각각 다른 이름으로 받음
		for (int i = 0; i < files.size(); i++) {
			String upfileName = "upfile" + i;
			MultipartFile inFile = files.get(upfileName);

			String saveFileName = fileManager.getFileName(tempDir, inFile.getOriginalFilename());

			try {
				// 파일을 폴더에 저장함
				FileUtil.copyFile(inFile.getInputStream(), new FileOutputStream(tempDir + "/" + saveFileName));

				HashMap fmap = new HashMap();
				fmap.put(upfileName, saveFileName);
				fmap.put("tempDir", tempDir);

				listFile.add(fmap);

			} catch (FileNotFoundException e) {
				response.setStatus(500);
				throw new RuntimeException(e);

			} catch (IOException e) {
				response.setStatus(500);
				throw new RuntimeException(e);
			} catch (Exception e) {
				response.setStatus(500);
				throw new RuntimeException(e);
			}

		}

		// 파일이름을 세션에 저장
		request.getSession().setAttribute("FILELIST", listFile);
	}

	/**
     * File Download
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/comm/fileDownload.do")
    public void fileDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String fileNo = request.getParameter("fileNo");

        Map params = new HashMap();
        params.put("fileNo", fileNo);

        String saveFileName  = "";
        String serverDirPath = "";
        String orgFileName   = "";

        Map fileInfo = fileService.viewFile(params);

        fileDownloadDetail(request, response, fileInfo);
    }

    /**
     * 파일 다운로드 상세내용 (파일정보를 map 객체로 전달받아 처리.
     * @param request
     * @param response
     * @param fileInfo
     * @throws Exception
     */
	public void fileDownloadDetail(HttpServletRequest request, HttpServletResponse response, Map fileInfo) throws Exception {


        String saveFileName  = "";
        String serverDirPath = "";
        String orgFileName   = "";

//        String fileNo = request.getParameter("fileNo");
//        Map params = new HashMap();
//        params.put("fileNo", fileNo);
//        Map fileInfo = fileService.viewFile(params);

        if (fileInfo != null) {
            saveFileName  = (String)fileInfo.get("fileSvrNm");
            serverDirPath = (String)fileInfo.get("filePath");
            orgFileName   = (String)fileInfo.get("fileOrgNm");
        } else {
            System.out.println("$$$$$$$$$$$$$$$$$  FILE DOWNLOAD ERROR : Not Server File.");
            throw new EgovBizException("첨부파일이 존재하지 않습니다. 관리자에게 문의바랍니다.");
        }

        //실제  디렉토리
        String realDir= ApplicationProperty.get("upload.real.dir");

        //파일 풀경로 가져옴
        String fullFileName = serverDirPath + "/" + saveFileName;

        logger.info("fullFileName : " + fullFileName);
        logger.info("orgFileName : " + orgFileName);

        //파일을  orgFileName의 이름으로 다운로드 함
        File f = new File(fullFileName);

        if (f.exists()) {
            logger.info("response charset : " + response.getCharacterEncoding());

            String userAgent = request.getHeader("User-Agent");

            // 파일명 인코딩 처리	(MSIE -> Trident)
            String downFilename = "";
            if (userAgent.toLowerCase().indexOf("msie") + userAgent.toLowerCase().indexOf("trident") > -1) {	// IE
            	downFilename = URLEncoder.encode(orgFileName, "UTF-8").replaceAll("\\+", "%20");;
            } else if (userAgent.toLowerCase().indexOf("chrome") > -1) {
            	downFilename = new String(orgFileName.getBytes(), "8859_1");
            } else if (userAgent.toLowerCase().indexOf("firefox") > -1) {
            	downFilename = new String(orgFileName.getBytes(), "8859_1");
            } else {
            	downFilename = new String(orgFileName.getBytes(), "8859_1");
            }
            logger.info("disposition filename : " + downFilename);

            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + downFilename + "\"");
            response.setHeader("Content-Transfer-Encoding", "binary;");

            byte[] buffer = new byte[1024];
            BufferedInputStream ins = new BufferedInputStream(new FileInputStream(f));
            BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());

            try {
                int read = 0;
                while ((read = ins.read(buffer)) != -1) {
                    outs.write(buffer, 0, read);
                }
                outs.close();
                ins.close();
            } catch (IOException e) {
                System.out.println("$$$$$$$$$$$$$$$$$  : FILE DOWNLOAD ERROR : $$$$$$$$$$$$$$$$$$");
            } finally {
                  if(outs!=null) outs.close();
                  if(ins!=null) ins.close();
            }
        } else {
            System.out.println("$$$$$$$$$$$$$$$$$  FILE DOWNLOAD ERROR : Not Server File.");
            throw new EgovBizException("첨부파일이 존재하지 않습니다. 관리자에게 문의바랍니다..");
        }
    }
	
	/**
	 * File size 체크 (20Mb 이하만 올릴수 있도록 설정)
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping("/comm/fileSizeCheck.do")
	private ModelAndView fileSizeCheck(HttpServletRequest request, HttpServletResponse response) throws IOException {

		ModelAndView mav = new ModelAndView();

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> files             = multipartRequest.getFileMap();

		HashMap fmap = new HashMap();
		
		int maxFileSize = FILE_SIZE * 1024 * 1024; // 20MB	
		
		for (int i = 0; i < files.size(); i++) {

			String upfileName = "upfile" + i;
			MultipartFile inFile = files.get(upfileName);


			try {
//					fmap.put("fileOrgNm", CommUtils.nvlTrim(inFile.getOriginalFilename()) );
//					fmap.put("fileSize" , inFile.getSize());
				
				logger.debug("파일 크기는 ::::: "+ inFile.getSize());
					
					if(inFile.getSize()>maxFileSize){
						fmap.put("flag", "false");
					}else{
						fmap.put("flag", "true");
					}
					
			} catch (Exception e) {
				throw new RuntimeException(e);
			}

		}

		logger.debug("File Upload End !!!");
		
    	mav.addObject("AJAX_MODEL", fmap);
    	mav.setViewName(ajaxView);
    	return mav;
	}
	
	/**
	 * File Upload
	 * @param request
	 * @param response
	 * @throws IOException
	 * @throws Exception
	 */
	@RequestMapping("/comm/editorfileUpload.do")
	private ModelAndView editorfileUpload(HttpServletRequest request, HttpServletResponse response) throws IOException {

		List listFile = new ArrayList();

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> files             = multipartRequest.getFileMap();
		String tempDir                               = ApplicationProperty.get("upload.img.dir");

		String[] arrPermFileViewFg = null;


		logger.debug("File Directory Create !!!");

		FileUtil.makeDirectories(tempDir);

		String saveFileName = "";
		int nWidth =0;
		int nHeight=0;
		for (int i = 0; i < files.size(); i++) {

			String upfileName = "upfile" + i;
			MultipartFile inFile = files.get(upfileName);

			if(inFile != null){
				saveFileName = fileManager.getFileName(tempDir, inFile.getOriginalFilename());
			}

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
					
					File file = new File(tempDir + saveFileName);
					BufferedImage bi = ImageIO.read(file);
					System.out.println( bi.getWidth() + "," + bi.getHeight() ); 
					
					int width = bi.getWidth();
					int height = bi.getHeight();
					int maxWidth = 640;
					int maxHeight = 320;
					
					if(width > maxWidth){
						float widthRatio = maxWidth/(float)width;
						nWidth = (int)(width*widthRatio);
						nHeight = (int)(height*widthRatio);
					}
					if(height > maxHeight){
						float heightRatio = maxHeight/(float)height;
						nWidth = (int)(width*heightRatio);
						nHeight = (int)(height*heightRatio);
					}
					
//					nWidth = nWidth / width;
//					height = height / height;
					
//			        final int RATIO = 0;
//			        final int SAME = -1;
//		            int destWidth = -1, destHeight = -1;
//		            
//		            if (width == SAME) {
//		                destWidth = width;
//		            } else if (width > 0) {
//		                destWidth = width;
//		            }
//		            
//		            if (height == SAME) {
//		                destHeight = height;
//		            } else if (height > 0) {
//		                destHeight = height;
//		            }
//		            
//		            if (width == RATIO && height == RATIO) {
//		                destWidth = width;
//		                destHeight = height;
//		            } else if (width == RATIO) {
//		                double ratio = ((double)destHeight) / ((double)height);
//		                destWidth = (int)((double)width * ratio);
//		            } else if (height == RATIO) {
//		                double ratio = ((double)destWidth) / ((double)width);
//		                destHeight = (int)((double)height * ratio);
//		            }
//		            
//		            nWidth = destWidth;
//		            nHeight = destHeight;
					
//					if(bi.getWidth()>700){
//						nWidth =  bi.getWidth() /2;
//						
//					}else {
//						nWidth = bi.getWidth();
//					}
//					
//					if(bi.getHeight()>700){
//						nHeight =  bi.getHeight() /2;
//					}else {
//						nHeight =  bi.getHeight();
//					}
					
//					// 기초정보 관리에서 인허가정보에 첨부된 file 관련 부분
//					if(arrPermFileViewFg != null){
//					    fmap.put("permViewFg", arrPermFileViewFg[i]);
//					}

//					listFile.add(fmap);
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
		
		String callback_func = (String)request.getParameter("callback_func");

		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + saveFileName + "\"");
		response.setHeader("Content-Transfer-Encoding", "binary;");		
    	
    	logger.info(">>>>> NoticeManageService.fileupload END <<<<<");
		return new ModelAndView("redirect:/se2/popup/quick_photo/callback.jsp?callback_func="+callback_func+"&bNewLine=true&sFileName="+saveFileName+"&sFileURL=/editorImg/"+saveFileName+"&nWidth="+nWidth+"&nHeight="+nHeight);
	}
	
	
	//################################################################
    //SUNDOSOFT 평가사업관리 > 평가사업등록
    //################################################################
	
	/**
	 * 2023.11.15 LHB
     * 샘플 및 양식 FILE DOWNLOAD (SYS_CODE)
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/comm/fileDownloadSample.do")
    public void fileDownloadSample(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String fileNo = request.getParameter("fileNo");

        Map params = new HashMap();
        params.put("fileNo", fileNo);

        String saveFileName  = "";
        String serverDirPath = "";
        String orgFileName   = "";

        Map fileInfo = fileService.viewSampleFile(params);

        fileSampleDownloadDetail(request, response, fileInfo);
    }
    
    /**
     * 파일 다운로드 상세내용 (파일정보를 map 객체로 전달받아 처리.
     * @param request
     * @param response
     * @param fileInfo
     * @throws Exception
     */
	public void fileSampleDownloadDetail(HttpServletRequest request, HttpServletResponse response, Map fileInfo) throws Exception {

        String saveFileName  = "";
        String serverDirPath = "";
        String orgFileName   = "";
        
        // 실제  디렉토리
        String realDir = ApplicationProperty.get("formfile.dir");

        if (fileInfo != null) {
            saveFileName  = (String)fileInfo.get("fileSvrNm");
            serverDirPath = realDir;
            orgFileName   = (String)fileInfo.get("fileOrgNm");
        } else {
            System.out.println("$$$$$$$$$$$$$$$$$ SAMPLE FILE DOWNLOAD ERROR : Not Server File.");
            throw new EgovBizException("첨부파일이 존재하지 않습니다. 관리자에게 문의바랍니다.");
        }

        //파일 풀경로 가져옴
        String fullFileName = serverDirPath + "/" + saveFileName;

        logger.info("fullFileName : " + fullFileName);
        logger.info("orgFileName : " + orgFileName);

        //파일을  orgFileName의 이름으로 다운로드 함
        File f = new File(fullFileName);

        if (f.exists()) {
            logger.info("response charset : " + response.getCharacterEncoding());

            String userAgent = request.getHeader("User-Agent");

            // 파일명 인코딩 처리	(MSIE -> Trident)
            String downFilename = "";
            if (userAgent.toLowerCase().indexOf("msie") + userAgent.toLowerCase().indexOf("trident") > -1) {	// IE
            	downFilename = URLEncoder.encode(orgFileName, "UTF-8").replaceAll("\\+", "%20");;
            } else if (userAgent.toLowerCase().indexOf("chrome") > -1) {
            	downFilename = new String(orgFileName.getBytes(), "8859_1");
            } else if (userAgent.toLowerCase().indexOf("firefox") > -1) {
            	downFilename = new String(orgFileName.getBytes(), "8859_1");
            } else {
            	downFilename = new String(orgFileName.getBytes(), "8859_1");
            }
            logger.info("disposition filename : " + downFilename);

            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + downFilename + "\"");
            response.setHeader("Content-Transfer-Encoding", "binary;");

            byte[] buffer = new byte[1024];
            BufferedInputStream ins = new BufferedInputStream(new FileInputStream(f));
            BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());

            try {
                int read = 0;
                while ((read = ins.read(buffer)) != -1) {
                    outs.write(buffer, 0, read);
                }
                outs.close();
                ins.close();
            } catch (IOException e) {
                System.out.println("$$$$$$$$$$$$$$$$$ : SAMPLE FILE DOWNLOAD ERROR : $$$$$$$$$$$$$$$$$$");
            } finally {
                  if(outs!=null) outs.close();
                  if(ins!=null) ins.close();
            }
        } else {
            System.out.println("$$$$$$$$$$$$$$$$$ SAMPLE FILE DOWNLOAD ERROR : Not Server File.");
            throw new EgovBizException("첨부파일이 존재하지 않습니다. 관리자에게 문의바랍니다..");
        }
    }
}