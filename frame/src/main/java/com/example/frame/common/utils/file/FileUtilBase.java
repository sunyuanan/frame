package com.example.frame.common.utils.file;

import com.example.frame.common.utils.RandomGUID;
import com.example.frame.common.utils.StringUtil;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URL;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.Date;

public class FileUtilBase {
    public FileUtilBase() {
    }

    public static void save(byte[] body, File file) throws IOException {
        writeToFile(body, file);
    }

    public static void save(byte[] body, String fileName, String filePath) throws IOException {
        writeToFile(body, fileName, filePath);
    }

    protected static void deleteFileDirectory(String filePath) {
        File file = new File(filePath);
        File[] fileList = file.listFiles();
        String dirPath = null;
        if (fileList != null) {
            for (int i = 0; i < fileList.length; ++i) {
                if (fileList[i].isFile()) {
                    fileList[i].delete();
                }

                if (fileList[i].isDirectory()) {
                    dirPath = fileList[i].getPath();
                    deleteFileDirectory(dirPath);
                }
            }
        }

        file.delete();
    }

    protected static byte[] getFileByte(String fileName, boolean isDelete)
            throws FileNotFoundException {
        FileInputStream fileInputStream = new FileInputStream(fileName);
        byte[] buffer = getFileByte((InputStream) fileInputStream);
        if (isDelete) {
            (new File(fileName)).delete();
        }

        return buffer;
    }

    protected static File writeToFile(byte[] buffer, String fileName, String filePath)
            throws IOException {
        File dir = new File(filePath);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        String abPath = filePath.concat(fileName);
        File file = new File(abPath);
        if (!file.exists()) {
            file.createNewFile();
        }

        FileOutputStream out = new FileOutputStream(file);
        out.write(buffer);
        out.close();
        return file;
    }

    protected static File writeToFile(byte[] buffer, File file) throws IOException {
        FileOutputStream out = new FileOutputStream(file);
        out.write(buffer);
        out.close();
        return file;
    }

    protected static byte[] getFileByte(URL url) throws IOException {
        return url != null ? getFileByte(url.openStream()) : null;
    }

    protected static byte[] getFileByte(InputStream in) {
        ByteArrayOutputStream out = new ByteArrayOutputStream(4096);

        try {
            copy(in, out);
        } catch (IOException var3) {
            var3.printStackTrace();
        }

        return out.toByteArray();
    }

    protected static void copy(InputStream in, OutputStream out) throws IOException {
        try {
            byte[] buffer = new byte[4096];
            boolean var3 = true;

            int nrOfBytes;
            while ((nrOfBytes = in.read(buffer)) != -1) {
                out.write(buffer, 0, nrOfBytes);
            }

            out.flush();
        } catch (IOException var16) {
        } finally {
            try {
                if (in != null) {
                    in.close();
                }
            } catch (IOException var15) {
            }

            try {
                if (out != null) {
                    out.close();
                }
            } catch (IOException var14) {
            }
        }
    }

    public static String getFileNameSuff(String fileName) {
        return fileName.substring(fileName.lastIndexOf("/") + 1);
    }

    public static String getFileName(String fileName) {
        int pos = fileName.lastIndexOf(".");
        return pos == -1 ? fileName : fileName.substring(fileName.lastIndexOf("/") + 1, pos);
    }

    public static long copyfile(File f1, File f2) throws Exception {
        mkdirs(f2.getParent());
        if (f2.exists() && f2.isFile()) {
            f2.delete();
        }

        System.out.println("添加：" + f2.getAbsolutePath());
        long time = (new Date()).getTime();
        int length = 2097152;
        FileInputStream in = new FileInputStream(f1);
        FileOutputStream out = new FileOutputStream(f2);
        FileChannel inC = in.getChannel();
        FileChannel outC = out.getChannel();
        ByteBuffer b = null;

        while (inC.position() != inC.size()) {
            if (inC.size() - inC.position() < (long) length) {
                length = (int) (inC.size() - inC.position());
            } else {
                length = 2097152;
            }

            b = ByteBuffer.allocateDirect(length);
            inC.read(b);
            b.flip();
            outC.write(b);
            outC.force(false);
        }

        inC.close();
        outC.close();
        return (new Date()).getTime() - time;
    }

    public static long copyfile(String filePath1, String filePath2) throws Exception {
        File f1 = new File(filePath1);
        File f2 = new File(filePath2);
        return copyfile(f1, f2);
    }

    public static void mkdirs(File file) {
        if (file.isFile()) {
            file = new File(file.getParent());
        }

        if (!file.exists()) {
            file.mkdirs();
        }
    }

    public static void mkdirs(String filePath) {
        File file = new File(filePath);
        mkdirs(file);
    }

    public static void createrFile(File file) throws IOException {
        mkdirs(file.getParent());
        if (!file.exists()) {
            file.createNewFile();
        }
    }

    public static File writeNewFile(byte[] buffer, File file) throws IOException {
        return writeToFile(buffer, file);
    }

    public static void deleteFile(File file) {
        System.out.println("删除文件：" + file.getAbsolutePath());
        file.delete();
    }

    public static void deleteFile(String filePath) {
        deleteFile(new File(filePath));
    }

    public static void deleteAndCopyFile(File file1, File file2) throws Exception {
        mkdirs(file2.getParent());
        if (file2.exists() && file2.isFile()) {
            file2.delete();
        }

        if (file1.exists() && file1.isFile()) {
            copyfile(file1, file2);
            file1.delete();
        }
    }

    public static void deleteAndCopyFile(String file1Path, String file2Path) throws Exception {
        File file1 = new File(file1Path);
        File file2 = new File(file2Path);
        deleteAndCopyFile(file1, file2);
    }

    public static String getExtention(String fileName) {
        int pos = fileName.lastIndexOf(".");
        return pos + 1 < fileName.length() ? fileName.substring(pos) : "";
    }

    public static String getFileType(String fileName) {
        int pos = fileName.lastIndexOf(".");
        return pos + 1 < fileName.length() ? fileName.substring(pos + 1) : "";
    }

    public static String getFileContent(String filePath) {
        File file = new File(filePath);
        return getFileContent(file);
    }

    public static String getFileContent(File file) {
        String htmlCode = "";

        try {
            String encoding = "UTF-8";
            if (file.isFile() && file.exists()) {
                BufferedReader bufferedReader =
                        new BufferedReader(new UnicodeReader(new FileInputStream(file), encoding));

                for (String lineTxt = null;
                     (lineTxt = bufferedReader.readLine()) != null;
                     htmlCode = htmlCode + lineTxt) {
                }

                bufferedReader.close();
            } else {
                System.out.println("找不到指定的文件");
            }
        } catch (Exception var5) {
            System.out.println("读取文件内容出错");
            var5.printStackTrace();
        }

        return htmlCode;
    }

    public static void upload(String filePath, String saveAsFileName, File upload) throws Exception {
        if (upload != null) {
            File file;
            if (!StringUtil.isNullorEmpty(filePath)) {
                file = new File(filePath);
                if (!file.exists()) {
                    file.mkdirs();
                }
            }

            filePath = filePath.concat(saveAsFileName);
            file = new File(filePath);
            deleteAndCopyFile(upload, file);
        }
    }

    public static String creatTempFile(String fileSrc, String tempDirectory) {
        String newFileName = RandomGUID.getFileUUID();
        String tempFileDir = tempDirectory + newFileName + getExtention(fileSrc);
        getExtention(fileSrc);
        File file1 = new File(fileSrc);
        File file2 = new File(tempFileDir);

        try {
            copyfile(file1, file2);
        } catch (Exception var7) {
            var7.printStackTrace();
            tempFileDir = "";
        }

        return tempFileDir;
    }


    public static String convertfilesize(long filesize) {
        String strunit = "bytes";
        String straftercomma = "";
        int intdivisor = 1;
        if (filesize >= 1048576L) {
            strunit = "mb";
            intdivisor = 1048576;
        } else if (filesize >= 1024L) {
            strunit = "kb";
            intdivisor = 1024;
        }

        if (intdivisor == 1) {
            return filesize + " " + strunit;
        } else {
            straftercomma = "" + 100L * (filesize % (long) intdivisor) / (long) intdivisor;
            if (straftercomma == "") {
                straftercomma = ".0";
            }

            return filesize / (long) intdivisor + "." + straftercomma + " " + strunit;
        }
    }

    public static String imgToBase64(File file) {
        BASE64Encoder encoder = new BASE64Encoder();

        try {
            BufferedImage bi = ImageIO.read(file);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(bi, "JPEG", baos);
            byte[] bytes = baos.toByteArray();
            return encoder.encodeBuffer(bytes).trim();
        } catch (IOException var5) {
            var5.printStackTrace();
            return null;
        }
    }

    public static String uploadImage(
            HttpServletRequest request, String path_deposit, MultipartFile file, boolean isRandomName) {
        try {
            String[] typeImg = new String[]{"gif", "png", "jpg", "doc", "xls", "pdf"};
            if (file != null) {
                String origName = file.getOriginalFilename();
                System.out.println("上传的文件原名称:" + origName);
                String type =
                        origName.indexOf(".") != -1
                                ? origName.substring(origName.lastIndexOf(".") + 1, origName.length())
                                : null;
                if (type != null) {
                    boolean booIsType = false;

                    for (int i = 0; i < typeImg.length; ++i) {
                        if (typeImg[i].equals(type.toLowerCase())) {
                            booIsType = true;
                        }
                    }

                    if (booIsType) {
                        String path = request.getSession().getServletContext().getRealPath(path_deposit);
                        String fileSrc = "";
                        if (isRandomName) {
                            origName = RandomGUID.getFileUUID() + origName.substring(origName.lastIndexOf("."));
                        }

                        File targetFile = new File(path, origName);
                        if (!targetFile.exists()) {
                            targetFile.mkdirs();
                        }

                        file.transferTo(targetFile);
                        fileSrc =
                                request.getScheme()
                                        + "://"
                                        + request.getServerName()
                                        + ":"
                                        + request.getServerPort()
                                        + request.getContextPath()
                                        + path_deposit
                                        + origName;
                        System.out.println("文件上传成功:" + fileSrc);
                        return fileSrc;
                    }
                }
            }

            return null;
        } catch (Exception var11) {
            var11.printStackTrace();
            return null;
        }
    }

    public static byte[] getBytes(String filePath) {
        byte[] buffer = null;

        try {
            File file = new File(filePath);
            FileInputStream fis = new FileInputStream(file);
            ByteArrayOutputStream bos = new ByteArrayOutputStream(1000);
            byte[] b = new byte[1000];

            int n;
            while ((n = fis.read(b)) != -1) {
                bos.write(b, 0, n);
            }

            fis.close();
            bos.close();
            buffer = bos.toByteArray();
        } catch (FileNotFoundException var7) {
            var7.printStackTrace();
        } catch (IOException var8) {
            var8.printStackTrace();
        }

        return buffer;
    }

    public static byte[] getBytes(InputStream in) {
        byte[] buffer = null;

        try {
            ByteArrayOutputStream bos = new ByteArrayOutputStream(1000);
            byte[] b = new byte[1000];

            int n;
            while ((n = in.read(b)) != -1) {
                bos.write(b, 0, n);
            }

            in.close();
            bos.close();
            buffer = bos.toByteArray();
        } catch (FileNotFoundException var5) {
            var5.printStackTrace();
        } catch (IOException var6) {
            var6.printStackTrace();
        }

        return buffer;
    }

    public static void editImg(String path, String targetParh) throws Exception {
        String path1 =
                FilePropertiesBase.getRootPath(
                        FilePropertiesBase.getValue("file.temp") + getFileNameSuff(path));
        File file = new File(path1);
        if (file.exists()) {
            String path2 =
                    FilePropertiesBase.getRootPath(
                            FilePropertiesBase.getValue(targetParh) + getFileNameSuff(path));

            try {
                copyfile(path1, path2);
            } catch (Exception var6) {
                var6.printStackTrace();
            }

            deleteFile(path1);
        }
    }


}
