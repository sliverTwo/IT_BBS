package com.sliver.controller.publics;

import com.sliver.common.pojo.BBSResult;
import com.sliver.common.utils.FileUtils;
import com.sliver.common.utils.IDUtils;
import com.sliver.common.utils.MD5Utils;
import com.sliver.service.FileService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import com.sliver.pojo.User;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;



@Controller
@RequestMapping("/upload")
public class UploadController {
    @Value("${uploadFileDir}")
    private  String uploadFileDir;

    @Value("${uploadImgDir}")
    private  String uploadImgDir;

    @Value("${allowImgExt}")
    private String allowImgExt;

    @Value("${allowFileExt}")
    private String allowFileExt;

    private Logger logger = Logger.getLogger(UploadController.class);

    @Autowired
    private FileService fileService;
	@ResponseBody
	@RequestMapping(value="uploadFile.do",method = RequestMethod.POST)
	public BBSResult fileUpload(HttpServletRequest request,
                                HttpSession session,
                                @RequestParam("introduce") String introduce,
                                @RequestParam("score") Integer score,
                                @RequestParam("fileName") String fileName,
                                @RequestParam("file") MultipartFile file)  {
        User user = (User)session.getAttribute("logUser");
        if(null == user){
            return BBSResult.build(554,"请登录后在上传！");
        }
	    // 检测文件是否为空
        if(file.isEmpty()){
           return BBSResult.build(1,"文件上传失败!");
        }
        // 检测文件后缀名
        final String originalFilename = file.getOriginalFilename();
        String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
        if(!allowFileExt.contains(fileExt)){
            return  BBSResult.build(555,"不支持的上传文件，请将文件使用工具打包后下载,支持的格式有："+allowFileExt);
        }
        // 文件路径
        String webPath=request.getSession().getServletContext().getRealPath("/");
        String filePath = uploadFileDir + IDUtils.getImgDir(fileName) +IDUtils.getImageName() + fileExt;
        String path = webPath + filePath;
        logger.info("filePath:" + path);
        try {
            File ff = new File(path);
            if(!ff.exists()){
                ff.mkdirs();
            }
            file.transferTo(ff);
            // 文件信息写入数据库
            com.sliver.pojo.File f = new com.sliver.pojo.File();
            f.setId(MD5Utils.getFileMD5(ff));
            com.sliver.pojo.File checkFile = fileService.getFileById(MD5Utils.getFileMD5(ff));
            if(checkFile != null){
                return  BBSResult.build(500,"服务器已有此资源");
            }
            f.setScore(score);
            f.setFilename(fileName+fileExt);
            f.setIntroduce(introduce);
            f.setUserId(user.getId());
            f.setUsername(user.getUsername());
            f.setPath(filePath);
            int i = fileService.insert(f);
            if(i <= 0){
                return BBSResult.build(555,"文件上传失败，请刷新后重试!");
            }
        } catch (IOException e) {
            logger.warn("文件上传失败，失败原因:\n" + e.getMessage());
            return BBSResult.build(555,"文件上传失败，请刷新后重试!");
        }

        return BBSResult.ok();
    }

    @ResponseBody
    @RequestMapping(value="uploadImg.do",method = RequestMethod.POST)
    public BBSResult uploadImg(HttpServletRequest request) {
        logger.info("uploadImgDir："+uploadImgDir);
        //将当前上下文初始化给  CommonsMutipartResolver （多部分解析器）
        CommonsMultipartResolver multipartResolver=new CommonsMultipartResolver(
                request.getSession().getServletContext());
        //检查form中是否有enctype="multipart/form-data"
        if(multipartResolver.isMultipart(request))
        {
            //将request变成多部分request
            MultipartHttpServletRequest multiRequest=(MultipartHttpServletRequest)request;
           //获取multiRequest 中所有的文件名
            Iterator iter=multiRequest.getFileNames();

            while(iter.hasNext())
            {
                //一次遍历所有文件
                MultipartFile file=multiRequest.getFile(iter.next().toString());
                if(file!=null)
                {
                    String fileName = IDUtils.getImageName();
                    final String originalFilename = file.getOriginalFilename();
                    String imgExt = originalFilename.substring(originalFilename.lastIndexOf("."));
                    logger.info("图片格式:" + imgExt);
                    // 检测文件类型
                    if(!allowImgExt.contains(imgExt)){
                        return BBSResult.build(555,"不支持的图片格式");
                    }
                    String imgPath = uploadImgDir + IDUtils.getImgDir(fileName) + fileName + imgExt;
                    String path=request.getSession().getServletContext().getRealPath("/")+imgPath;
                    logger.info("文件路径：" + path);

                    //上传
                    try {
                        File dir = new File(path);
                        if(!dir.exists()){
                            dir.mkdirs();
                        }
                        file.transferTo(dir);
                    } catch (IOException e) {
                        logger.warn("文件上传失败，失败信息:" + e.getMessage());
                        return BBSResult.build(555,"文件上传失败，请刷新后重试!");

                    }
                    Map<String, String> m = new HashMap<>();
                    m.put("src",request.getContextPath()+FileUtils.FILE_SEPA + imgPath);
                    m.put("title",fileName);
                    return BBSResult.ok(m);
                }

            }
        }
        return BBSResult.build(555,"上传失败！");
    }

}
