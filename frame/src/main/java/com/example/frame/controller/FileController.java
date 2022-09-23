package com.example.frame.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import com.alibaba.fastjson.JSONObject;
import com.example.frame.common.aop.annotation.LogAnnotation;
import com.example.frame.common.utils.DataResult;
import com.example.frame.common.utils.StringUtil;
import com.example.frame.common.utils.file.FilePropertiesBase;
import com.example.frame.common.utils.file.FileUploadUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

/**
 * @author sya
 * @Date 2021/12/18 21:47
 */
@Api(tags = "文件上传下载")
@Slf4j
@Controller
@RequestMapping("/file")
public class FileController {

    /**
     * 通用上传请求
     */
    @PostMapping("/upload")
    @ResponseBody
    @ApiOperation(value = "附件上传")
    @LogAnnotation(title = "附件上传", action = "附件上传")
    @ApiImplicitParam(name = "file", value = "附件", dataType = "File", required = true)
    @SaCheckPermission("file-upload")
    public DataResult uploadFile(MultipartFile file) throws Exception {
        ///文件原名称
        String realName = file.getOriginalFilename();
        //文件后缀名
        String fileStuff = realName.substring(realName.lastIndexOf("."));
        // 上传文件路径shiubshi
        String filePath = FilePropertiesBase.getRootPath() + FilePropertiesBase.getValue("file.temp");
        // 上传并返回新文件名称
        String fileName = FileUploadUtils.upload(filePath, file, fileStuff);
        JSONObject object = new JSONObject();
        object.put("filePath", FilePropertiesBase.getValue("file.temp"));
        object.put("realName", realName);
        object.put("fileName", fileName);
        return DataResult.success(object);
    }


    /** 通用下载请求 */
    @GetMapping("/download")
    @ApiOperation(value = "查看（下载）附件")
    @LogAnnotation(title = "查看（下载）附件", action = "查看（下载）附件")
    @SaCheckPermission("file-download")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "filename", value ="附件原名称（ysmc）", dataType = "String", required = true),
            @ApiImplicitParam(name = "filepath", value ="附件相对路径（fjlj）", dataType = "String", required = true)
    })
    public void fileDownload(HttpServletRequest request, HttpServletResponse response) {
        String fileName = request.getParameter("filename");
        String realPath = request.getParameter("filepath");
        if (realPath.lastIndexOf("?") != -1) {
            realPath = realPath.substring(0, realPath.lastIndexOf("?"));
        }
        if (realPath != null && !StringUtil.isNullorEmpty(realPath)) {
            // 当前是从该工程的WEB-INF//File//下获取文件(该目录可以在下面一行代码配置)然后下载到C:\\users\\downloads即本机的默认下载的目录
      /* String realPath = request.getServletContext().getRealPath(
      "//WEB-INF//");*/
            File file = new File(FilePropertiesBase.getRootPath(realPath));
            if (file.exists()) {
                response.setContentType("application/force-download"); // 设置强制下载不打开
                String downloadFileName = null;
                try {
                    downloadFileName = new String((fileName).getBytes(), "ISO-8859-1");
                    response.addHeader("Content-Disposition", "attachment; filename=\"" + downloadFileName + "\"");
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
                byte[] buffer = new byte[1024];
                FileInputStream fis = null;
                BufferedInputStream bis = null;
                try {
                    fis = new FileInputStream(file);
                    bis = new BufferedInputStream(fis);
                    OutputStream os = response.getOutputStream();
                    int i = bis.read(buffer);
                    while (i != -1) {
                        os.write(buffer, 0, i);
                        i = bis.read(buffer);
                    }
                    System.out.println("success");
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (bis != null) {
                        try {
                            bis.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                    if (fis != null) {
                        try {
                            fis.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
    }


}
