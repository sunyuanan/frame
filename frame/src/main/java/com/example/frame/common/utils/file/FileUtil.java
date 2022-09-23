package com.example.frame.common.utils.file;

import com.example.frame.common.utils.RandomGUID;
import com.example.frame.common.utils.StringUtil;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;
import sun.misc.BASE64Encoder;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * @author
 */

public class FileUtil extends FileUtilBase {
    public static String imgToBase64(File file) {

        BASE64Encoder encoder = new BASE64Encoder();
        BufferedImage bi;
        try {
            bi = ImageIO.read(file);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(bi, "JPEG", baos);
            byte[] bytes = baos.toByteArray();

            return encoder.encodeBuffer(bytes).trim();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String getFileNameSuff(String fileName) {
        return fileName.substring(fileName.lastIndexOf("/") + 1);
    }

    /**
     * 上传图片 原名称
     *
     * @param request      请求
     * @param path_deposit 存放位置(路径)
     * @param file         文件
     * @param isRandomName 是否随机名称
     * @return 完整文件路径
     */
    public static String uploadImage(
            HttpServletRequest request, String path_deposit, MultipartFile file, boolean isRandomName) {
        // 上传
        try {
            String[] typeImg = {"gif", "png", "jpg", "doc", "xls", "pdf"};
            if (file != null) {
                String origName = file.getOriginalFilename(); // 文件原名称
                System.out.println("上传的文件原名称:" + origName);
                // 判断文件类型
                String type =
                        origName.indexOf(".") != -1
                                ? origName.substring(origName.lastIndexOf(".") + 1, origName.length())
                                : null;
                if (type != null) {
                    boolean booIsType = false;
                    for (int i = 0; i < typeImg.length; i++) {
                        if (typeImg[i].equals(type.toLowerCase())) {
                            booIsType = true;
                        }
                    }
                    // 类型正确
                    if (booIsType) {
                        // 存放图片文件的路径
                        String path = request.getSession().getServletContext().getRealPath(path_deposit);
                        // 组合名称
                        String fileSrc = "";
                        // 是否随机名称
                        if (isRandomName) {
                            origName = RandomGUID.getFileUUID() + origName.substring(origName.lastIndexOf("."));
                        }
                        // 判断是否存在目录
                        File targetFile = new File(path, origName);
                        if (!targetFile.exists()) {
                            targetFile.mkdirs(); // 创建目录
                        }
                        // 上传
                        file.transferTo(targetFile);
                        // 完整路径
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
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    public static void writeToLocal(String destination, InputStream input) throws IOException {

        int index;
        byte[] bytes = new byte[1024];
        FileOutputStream downloadFile = new FileOutputStream(destination);
        while ((index = input.read(bytes)) != -1) {
            downloadFile.write(bytes, 0, index);
            downloadFile.flush();
        }
        input.close();
        downloadFile.close();
    }

    /**
     * 获取文件夹中的所有文件
     */
    public static ArrayList<File> getFiles(String path) throws Exception {
        // 目标集合fileList
        ArrayList<File> fileList = new ArrayList<File>();
        File file = new File(path);
        if (file.isDirectory()) {
            File[] files = file.listFiles();
            for (File fileIndex : files) {
                // 如果这个文件是目录，则进行递归搜索
                if (fileIndex.isDirectory()) {
                    getFiles(fileIndex.getPath());
                } else {
                    // 如果文件是普通文件，则将文件句柄放入集合中
                    fileList.add(fileIndex);
                }
            }
        }
        return fileList;
    }

    /**
     * 模拟post方式上传文件
     */
    public static Boolean uploadFile(File file, String url1) {
        Boolean uploadresult = false;
        try {
            String result = "";
            // 换行符
            final String newLine = "\r\n";
            final String boundaryPrefix = "--";
            // 定义数据分隔线
            String BOUNDARY = "========7d4a6d158c9";
            // 服务器的域名
            URL url = new URL(url1);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            // 设置为POST情
            conn.setRequestMethod("POST");
            // 发送POST请求必须设置如下两行
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            // 设置请求头参数
            conn.setRequestProperty("connection", "Keep-Alive");
            conn.setRequestProperty("Charsert", "UTF-8");
            conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);

            OutputStream out = new DataOutputStream(conn.getOutputStream());

            // 上传文件
            StringBuilder sb = new StringBuilder();
            sb.append(boundaryPrefix);
            sb.append(BOUNDARY);
            sb.append(newLine);
            // 文件参数,photo参数名可以随意修改
            sb.append(
                    "Content-Disposition: form-data;name=\"photo\";filename=\""
                            + file.getName()
                            + "\""
                            + newLine);
            sb.append("Content-Type:application/octet-stream");
            // 参数头设置完以后需要两个换行，然后才是参数内容
            sb.append(newLine);
            sb.append(newLine);

            // 将参数头的数据写入到输出流中
            out.write(sb.toString().getBytes());

            // 数据输入流,用于读取文件数据
            DataInputStream in = new DataInputStream(new FileInputStream(file));
            byte[] bufferOut = new byte[1024];
            int bytes = 0;
            // 每次读1KB数据,并且将文件数据写入到输出流中
            while ((bytes = in.read(bufferOut)) != -1) {
                out.write(bufferOut, 0, bytes);
            }
            // 最后添加换行
            out.write(newLine.getBytes());
            in.close();

            // 定义最后数据分隔线，即--加上BOUNDARY再加上--。
            byte[] end_data = (newLine + boundaryPrefix + BOUNDARY + boundaryPrefix + newLine).getBytes();
            // 写上结尾标识
            out.write(end_data);
            out.flush();
            out.close();
            // 定义BufferedReader输入流来读取URL的响应
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String line = null;
            while ((line = reader.readLine()) != null) {
                System.out.println("767676" + line);
                result += line;
            }
            uploadresult = true;
        } catch (Exception e) {
            System.out.println("发送POST请求出现异常！" + e);
            e.printStackTrace();
        }
        return uploadresult;
    }

    public static String sizeFormatNum2String(long size) {
        String s = "";
        if (size > 1024 * 1024) {
            s = String.format("%.2f", (double) size / (1024)) + "M";
        } else {
            s = String.format("%.2f", (double) size / (1024)) + "KB";
        }
        return s;
    }

    public static void writeFile(String content) {
        File dir = new File("D:\\tempVideoText");
        if (!dir.exists()) {
            dir.mkdir();
        }
        try {
            File writeName =
                    new File(
                            "D:\\tempVideoText\\"
                                    + RandomGUID.getDateUUID()
                                    + ".txt"); // 相对路径，如果没有则要建立一个新的output.txt文件
            writeName.createNewFile(); // 创建新文件,有同名的文件的话直接覆盖
            try (FileWriter writer = new FileWriter(writeName);
                 BufferedWriter out = new BufferedWriter(writer)) {
                out.write(content); // \r\n即为换行
                out.flush(); // 把缓存区内容压入文件
                out.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String readFile(String path) {
        // 防止文件建立或读取失败，用catch捕捉错误并打印，也可以throw;
        // 不关闭文件会导致资源的泄露，读写文件都同理
        // Java7的try-with-resources可以优雅关闭文件，异常时自动关闭文件；详细解读https://stackoverflow.com/a/12665271
        FileReader fr = null;
        try {
            fr = new FileReader(path);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        BufferedReader br = new BufferedReader(fr);
        String str = null;
        try {
            str = br.readLine();
            br.close();
            fr.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return str;
    }

    /**
     * 获取目录下所有文件(按时间排序)
     */
    public static List<File> getFileSort(String path) {

        List<File> list = getFiles(path, new ArrayList<File>());

        if (list != null && list.size() > 0) {

            Collections.sort(
                    list,
                    new Comparator<File>() {
                        @Override
                        public int compare(File file, File newFile) {
                            if (file.lastModified() > newFile.lastModified()) {
                                return 1;
                            } else if (file.lastModified() == newFile.lastModified()) {
                                return 0;
                            } else {
                                return -1;
                            }
                        }
                    });
        }
        return list;
    }

    /**
     * 获取目录下所有文件
     */
    public static List<File> getFiles(String realpath, List<File> files) {

        File realFile = new File(realpath);
        if (realFile.isDirectory()) {
            File[] subfiles = realFile.listFiles();
            for (File file : subfiles) {
                if (file.isDirectory()) {
                    getFiles(file.getAbsolutePath(), files);
                } else {
                    files.add(file);
                }
            }
        }
        return files;
    }

    // 获取文件夹的大小
    public StringBuffer sb;
    public static double sizes;

    public static void recurseFile(String path) {
        if (path.indexOf(".") == -1) {
            for (File file : new File(path).listFiles()) {
                if (file.isFile()) {
                    sizes += file.length();
                } else {
                    recurseFile(file.toString());
                }
            }
        } else {
            sizes = new File(path).length();
        }
    }

    // 删除指定文件夹下所有文件
    // param path 文件夹完整绝对路径
    public static boolean delAllFile(String path) {
        boolean flag = false;
        File file = new File(path);
        if (!file.exists()) {
            return flag;
        }
        if (!file.isDirectory()) {
            return flag;
        }
        String[] tempList = file.list();
        File temp = null;
        for (int i = 0; i < tempList.length; i++) {
            if (path.endsWith(File.separator)) {
                temp = new File(path + tempList[i]);
            } else {
                temp = new File(path + File.separator + tempList[i]);
            }
            if (temp.isFile()) {
                temp.delete();
            }
            if (temp.isDirectory()) {
                delAllFile(path + "/" + tempList[i]); // 先删除文件夹里面的文件
                flag = true;
            }
        }
        return flag;
    }

    public static void main(String[] args) {
        recurseFile(FilePropertiesBase.getRootPath() + "yshsp/");
        System.out.println(sizes);
        if (sizes > 22000.0) {
            delAllFile(FilePropertiesBase.getRootPath() + "yshsp/");
        }
    }

    public static String getExtention(String fileName) {
        int pos = fileName.lastIndexOf(".");
        return pos + 1 < fileName.length() ? fileName.substring(pos) : "";
    }

}
