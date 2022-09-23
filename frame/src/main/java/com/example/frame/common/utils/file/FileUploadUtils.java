package com.example.frame.common.utils.file;

import com.example.frame.common.exception.BusinessException;
import com.example.frame.common.exception.code.BaseResponseCode;
import com.example.frame.common.utils.DateUtils;
import com.example.frame.common.utils.Md5Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;

public class FileUploadUtils {
    private static final Logger log = LoggerFactory.getLogger(FileUploadUtils.class);

    /**
     * 默认大小 50M
     */
    public static final long DEFAULT_MAX_SIZE = 50 * 1024 * 1024;

    /**
     * 默认的文件名最大长度 100
     */
    public static final int DEFAULT_FILE_NAME_LENGTH = 100;

    /**
     * 默认上传的地址
     */
    private static String defaultBaseDir = "d://";

    /**
     * 默认文件类型jpg
     */
    public static final String IMAGE_JPG_EXTENSION = ".jpg";

    private static int counter = 0;

    public static void setDefaultBaseDir(String defaultBaseDir) {
        FileUploadUtils.defaultBaseDir = defaultBaseDir;
    }

    public static String getDefaultBaseDir() {
        return defaultBaseDir;
    }

    /**
     * 以默认配置进行文件上传
     *
     * @param file 上传的文件
     * @return 文件名称
     */
    public static final String upload(MultipartFile file) throws IOException {
        try {
            return upload(getDefaultBaseDir(), file, FileUploadUtils.IMAGE_JPG_EXTENSION);
        } catch (Exception e) {
            throw new IOException(e.getMessage(), e);
        }
    }

    /**
     * 根据文件路径上传
     *
     * @param baseDir 相对应用的基目录
     * @param file    上传的文件
     * @return 文件名称
     */
    public static final String upload(String baseDir, MultipartFile file) throws IOException {
        try {
            return upload(baseDir, file, FileUploadUtils.IMAGE_JPG_EXTENSION);
        } catch (Exception e) {
            throw new IOException(e.getMessage(), e);
        }
    }

    /**
     * 文件上传
     *
     * @param baseDir   相对应用的基目录
     * @param file      上传的文件
     * @param extension 上传文件类型
     * @return 返回上传成功的文件名
     * @throws IOException 比如读写文件出错时
     */
    public static final String upload(String baseDir, MultipartFile file, String extension) {
        int fileNamelength = file.getOriginalFilename().length();
        if (fileNamelength > FileUploadUtils.DEFAULT_FILE_NAME_LENGTH) {
            throw new BusinessException(BaseResponseCode.DEFAULT_FILE_NAME_LENGTH.getCode(), "文件名过大");
        }
        assertAllowed(file);
        String fileName = extractFilenameNoTime(file, extension);
        File desc = null;
        try {
            desc = getAbsoluteFile(baseDir, baseDir + fileName);
            file.transferTo(desc);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return fileName;
    }

    public static final String extractFilename(MultipartFile file, String extension) {
        String filename = file.getOriginalFilename();
        filename = DateUtils.datePath() + "/" + encodingFilename(filename) + extension;
        return filename;
    }

    public static final String extractFilenameNoTime(MultipartFile file, String extension) {
        String filename = file.getOriginalFilename();
        filename = encodingFilename(filename) + extension;
        return filename;
    }

    private static final File getAbsoluteFile(String uploadDir, String filename) throws IOException {
        File desc = new File(File.separator + filename);

        if (!desc.getParentFile().exists()) {
            desc.getParentFile().mkdirs();
        }
        if (!desc.exists()) {
            desc.createNewFile();
        }
        return desc;
    }

    /**
     * 编码文件名
     */
    public static final String encodingFilename(String filename) {
        filename = filename.replace("_", " ");
        filename = Md5Utils.hash(filename + System.nanoTime() + counter++);
        return filename;
    }

    /**
     * 文件大小校验
     *
     * @param file 上传的文件
     */
    public static final void assertAllowed(MultipartFile file) {
        long size = file.getSize();
        if (DEFAULT_MAX_SIZE != -1 && size > DEFAULT_MAX_SIZE) {
            throw new BusinessException(BaseResponseCode.DEFAULT_MAX_SIZE.getCode(), "文件过大");
        }
    }
}
