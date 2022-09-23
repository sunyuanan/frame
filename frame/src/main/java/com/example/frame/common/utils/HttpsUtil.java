package com.example.frame.common.utils;


import com.alibaba.fastjson.JSONObject;
import com.example.frame.common.utils.file.FilePropertiesBase;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.nio.file.Paths;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

/**
 * @author sya
 * Created by Administrator on 2019/4/6 0006.
 */
public class HttpsUtil {
    private static final Logger logger = LoggerFactory.getLogger(HttpsUtil.class);

    /**
     * 缓冲区大小
     */
    private static int BUFFER_SIZE = 8096;
    /**
     * 调试用
     */
    public static final boolean DEBUG = true;


    /**
     * Logger for this class.
     */
    private static TrustManager myX509TrustManager =
            new X509TrustManager() {
                @Override
                public void checkClientTrusted(X509Certificate[] arg0, String arg1)
                        throws CertificateException {
                }

                @Override
                public void checkServerTrusted(X509Certificate[] arg0, String arg1)
                        throws CertificateException {
                }

                @Override
                public X509Certificate[] getAcceptedIssuers() {
                    return null;
                }
            };

    /**
     * 发送post请求
     *
     * @param url  目标地址
     * @param data 参数
     * @return 请求结果
     */
    public static JSONObject post(String url, String data, boolean isHttps) {
        try {

            // 打开连接
            // 要发送的POST请求url?Key=Value&amp;Key2=Value2&amp;Key3=Value3的形式
            URL requestUrl = new URL(url);
            int code = 0;
            InputStream inputStream = null;
            InputStreamReader inputStreamReader = null;
            BufferedReader bufferedReader = null;
            String responseResult = "";
            if (isHttps) {
                SSLContext sslcontext = SSLContext.getInstance("TLS");
                sslcontext.init(null, new TrustManager[]{myX509TrustManager}, null);
                HttpsURLConnection httpsConn = (HttpsURLConnection) requestUrl.openConnection();
                httpsConn.setSSLSocketFactory(sslcontext.getSocketFactory());
                httpsConn.setRequestMethod("POST");
                httpsConn.setDoOutput(true);
                OutputStream out = httpsConn.getOutputStream();
                if (data != null) {
                    out.write(data.getBytes("UTF-8"));
                }
                out.flush();
                out.close();
                inputStream = httpsConn.getInputStream();
                code = httpsConn.getResponseCode();
            } else {

                HttpURLConnection httpConn = (HttpURLConnection) requestUrl.openConnection();
                // 加入数据
                httpConn.setRequestMethod("POST");
                httpConn.setDoOutput(true);
                OutputStream out = httpConn.getOutputStream();
                if (data != null) {
                    out.write(data.getBytes("UTF-8"));
                }
                out.flush();
                out.close();
                // 获取输入流
                inputStream = httpConn.getInputStream();
                code = httpConn.getResponseCode();
            }
            if (HttpsURLConnection.HTTP_OK == code) {
                inputStreamReader = new InputStreamReader(inputStream, "UTF-8");
                bufferedReader = new BufferedReader(inputStreamReader);
                String str = null;
                StringBuffer buffer = new StringBuffer();
                while ((str = bufferedReader.readLine()) != null) {
                    buffer.append(str);
                }
                responseResult = buffer.toString();
                logger.info(responseResult);
                return JSONObject.parseObject(responseResult);
            }
        } catch (KeyManagementException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (ProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static String postString(String url, String data, boolean isHttps) {
        try {

            // 打开连接
            // 要发送的POST请求url?Key=Value&amp;Key2=Value2&amp;Key3=Value3的形式
            URL requestUrl = new URL(url);
            int code = 0;
            InputStream inputStream = null;
            InputStreamReader inputStreamReader = null;
            BufferedReader bufferedReader = null;
            String responseResult = "";
            if (isHttps) {
                // 设置SSLContext
                SSLContext sslcontext = SSLContext.getInstance("TLS");
                sslcontext.init(null, new TrustManager[]{myX509TrustManager}, null);

                HttpsURLConnection httpsConn = (HttpsURLConnection) requestUrl.openConnection();
                // 设置套接工厂
                httpsConn.setSSLSocketFactory(sslcontext.getSocketFactory());
                // 加入数据
                httpsConn.setRequestMethod("POST");
                httpsConn.setDoOutput(true);
                OutputStream out = httpsConn.getOutputStream();
                if (data != null) {
                    out.write(data.getBytes("UTF-8"));
                }
                out.flush();
                out.close();
                // 获取输入流
                inputStream = httpsConn.getInputStream();
                code = httpsConn.getResponseCode();
            } else {

                HttpURLConnection httpConn = (HttpURLConnection) requestUrl.openConnection();
                // 加入数据
                httpConn.setRequestMethod("POST");
                httpConn.setDoOutput(true);
                OutputStream out = httpConn.getOutputStream();
                if (data != null) {
                    out.write(data.getBytes("UTF-8"));
                }
                out.flush();
                out.close();
                // 获取输入流
                inputStream = httpConn.getInputStream();
                code = httpConn.getResponseCode();
            }

            if (HttpsURLConnection.HTTP_OK == code) {
                inputStreamReader = new InputStreamReader(inputStream, "UTF-8");
                bufferedReader = new BufferedReader(inputStreamReader);
                String str = null;
                StringBuffer buffer = new StringBuffer();
                while ((str = bufferedReader.readLine()) != null) {
                    buffer.append(str);
                }
                responseResult = buffer.toString();
                // logger.info("response result : {}" , responseResult);
                return responseResult;
            }
        } catch (KeyManagementException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (ProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }

    public static JSONObject get(String url, Map map) {
        String getstr = formatFormParameters(map);
        url += "?" + getstr;
        return get(url, false);
    }

    /**
     * 发送get请求
     *
     * @param url 请求地址
     * @return 请求结果
     */
    public static JSONObject get(String url, boolean isHttps) {
        try {
            InputStream inputStream = null;
            InputStreamReader inputStreamReader = null;
            BufferedReader bufferedReader = null;
            String responseResult = "";
            int code;
            if (isHttps) {
                // 设置SSLContext
                SSLContext sslcontext = SSLContext.getInstance("TLS");
                sslcontext.init(null, new TrustManager[]{myX509TrustManager}, null);
                // 打开连接
                // 要发送的POST请求url?Key=Value&amp;Key2=Value2&amp;Key3=Value3的形式
                URL requestUrl = new URL(url);
                HttpsURLConnection httpsConn = (HttpsURLConnection) requestUrl.openConnection();
                // 设置套接工厂
                httpsConn.setSSLSocketFactory(sslcontext.getSocketFactory());

                // 加入数据
                httpsConn.setRequestMethod("GET");
                // httpsConn.setDoOutput(true);
                // 获取输入流
                inputStream = httpsConn.getInputStream();

                code = httpsConn.getResponseCode();
            } else {

                // 打开连接
                // 要发送的POST请求url?Key=Value&amp;Key2=Value2&amp;Key3=Value3的形式
                URL requestUrl = new URL(url);
                HttpURLConnection httpConn = (HttpURLConnection) requestUrl.openConnection();

                // 加入数据
                httpConn.setRequestMethod("GET");
                // httpsConn.setDoOutput(true);
                // 获取输入流
                inputStream = httpConn.getInputStream();
                code = httpConn.getResponseCode();
            }

            if (HttpsURLConnection.HTTP_OK == code) {
                inputStreamReader = new InputStreamReader(inputStream, "UTF-8");
                bufferedReader = new BufferedReader(inputStreamReader);
                String str = null;
                StringBuffer buffer = new StringBuffer();
                while ((str = bufferedReader.readLine()) != null) {
                    buffer.append(str);
                }
                responseResult = buffer.toString();
                // logger.info("response result : {}" , responseResult);
                return JSONObject.parseObject(responseResult);
            }
        } catch (KeyManagementException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (ProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null;
    }


    /**
     * 保存http资源到服务器文件系统
     *
     * @param destUrl  图片网络路径
     * @param filePath 图片服务器路径含文件名
     */
    public static String downloadFile(String destUrl, String filePath) throws IOException {
        // 如果不存在这个目录，就新建一个
        File targetFile = new File(filePath);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }
        FileOutputStream fos = null;
        BufferedInputStream bis = null;
        HttpURLConnection httpUrl = null;
        URL url = null;
        byte[] buf = new byte[BUFFER_SIZE];
        int size = 0;
        // 建立链接
        url = new URL(destUrl);
        httpUrl = (HttpURLConnection) url.openConnection();
        // 连接指定的资源
        httpUrl.connect();
        String filemime = httpUrl.getHeaderField("Content-Type");
        String fileName = UUID.randomUUID().toString();
        String fileExt = GetExtByMime(filemime);
        String filePathWithName = Paths.get(filePath, fileName + fileExt).toString();

        // 获取网络输入流
        bis = new BufferedInputStream(httpUrl.getInputStream());
        // 建立文件
        fos = new FileOutputStream(filePathWithName);
        if (DEBUG) {
            logger.info("正在获取链接[" + destUrl + "]的内容.../n将其保存为文件[" + filePathWithName + "]");
        }
        // 保存文件
        while ((size = bis.read(buf)) != -1) {
        }

        fos.close();
        bis.close();
        httpUrl.disconnect();
        return fileName + fileExt;
    }

    /**
     * @param url:请求url
     * @param content: 请求体(参数)
     * @return errorStr:错误信息;status:状态码，response：返回数据
     */
    /**
     * @param strURL 路径
     * @param params {"a":"b"}
     */
    public static String request(String strURL, String params) {
        logger.info(strURL);
        logger.info(params);
        try {
            URL url = new URL(strURL); // 创建连接
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setUseCaches(false);
            connection.setInstanceFollowRedirects(true);
            connection.setRequestMethod("POST"); // 设置请求方式
            connection.setRequestProperty("Accept", "application/json"); // 设置接收数据的格式
            connection.setRequestProperty("Content-Type", "application/json"); // 设置发送数据的格式
            connection.connect();
            OutputStreamWriter out =
                    new OutputStreamWriter(connection.getOutputStream(), "UTF-8"); // utf-8编码
            out.append(params);
            out.flush();
            out.close();
            // 读取响应
            int length = (int) connection.getContentLength(); // 获取长度
            InputStream is = connection.getInputStream();
            if (length != -1) {
                byte[] data = new byte[length];
                byte[] temp = new byte[512];
                int readLen = 0;
                int destPos = 0;
                while ((readLen = is.read(temp)) > 0) {
                    System.arraycopy(temp, 0, data, destPos, readLen);
                    destPos += readLen;
                }
                String result = new String(data, "UTF-8"); // utf-8编码
                logger.info(result);
                return result;
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return "error"; // 自定义错误信息
    }

    /**
     * 根据url地址的content-type返回文件后缀名. 目前只有 jpg 后续扩展其他类型.
     */
    private static String GetExtByMime(String mimename) {

        return ".jpg";
    }

    private static String formatFormParameters(Map map) {
        if (map == null) {
            throw new IllegalArgumentException("参数为空!");
        }
        StringBuffer sb = new StringBuffer();
        for (Iterator iter = map.entrySet().iterator(); iter.hasNext(); ) {
            Entry entry = (Entry) iter.next();
            sb.append(entry.getKey())
                    .append("=")
                    .append(entry.getValue() != null ? entry.getValue().toString() : "");
            if (iter.hasNext()) {
                sb.append("&");
            }
        }
        return sb.toString();
    }

    /**
     * put请求
     *
     * @param obj {“a”：“b”}
     */
    public static JSONObject getUploadInformation(String path, String obj) throws IOException {
        JSONObject result = new JSONObject();
        // 创建连接
        URL url = new URL(path);
        HttpURLConnection connection;
        StringBuffer sbuffer = null;
        try {
            // 添加 请求内容
            connection = (HttpURLConnection) url.openConnection();
            // 设置http连接属性
            connection.setDoOutput(true); // http正文内，因此需要设为true, 默认情况下是false;
            connection.setDoInput(true); // 设置是否从httpUrlConnection读入，默认情况下是true;
            connection.setRequestMethod("PUT"); // 可以根据需要 提交 GET、POST、DELETE、PUT等http提供的功能
            // connection.setUseCaches(false);//设置缓存，注意设置请求方法为post不能用缓存
            // connection.setInstanceFollowRedirects(true);

            connection.setRequestProperty("Host", "*******"); // 设置请 求的服务器网址，域名，例如***.**.***.***
            connection.setRequestProperty(
                    "Content-Type", " application/json"); // 设定 请求格式 json，也可以设定xml格式的
            connection.setRequestProperty("Accept-Charset", "utf-8"); // 设置编码语言
            connection.setRequestProperty("X-Auth-Token", "token"); // 设置请求的token

            connection.setRequestProperty("Connection", "keep-alive"); // 设置连接的状态
            connection.setRequestProperty("Transfer-Encoding", "chunked"); // 设置传输编码
            connection.setRequestProperty(
                    "Content-Length", obj.toString().getBytes().length + ""); // 设置文件请求的长度

            connection.setReadTimeout(10000); // 设置读取超时时间
            connection.setConnectTimeout(10000); // 设置连接超时时间
            connection.connect();
            OutputStream out = connection.getOutputStream(); // 向对象输出流写出数据，这些数据将存到内存缓冲区中
            out.write(obj.toString().getBytes()); // out.write(new String("测试数据").getBytes());
            // //刷新对象输出流，将任何字节都写入潜在的流中
            out.flush();
            // 关闭流对象,此时，不能再向对象输出流写入任何数据，先前写入的数据存在于内存缓冲区中
            out.close();
            // 读取响应
            if (connection.getResponseCode() == 200) {
                // 从服务器获得一个输入流
                InputStreamReader inputStream =
                        new InputStreamReader(
                                connection.getInputStream()); // 调用HttpURLConnection连接对象的getInputStream()函数,
                // 将内存缓冲区中封装好的完整的HTTP请求电文发送到服务端。
                BufferedReader reader = new BufferedReader(inputStream);

                String lines;
                sbuffer = new StringBuffer("");

                while ((lines = reader.readLine()) != null) {
                    lines = new String(lines.getBytes(), "utf-8");
                    sbuffer.append(lines);
                }
                reader.close();
                result = JSONObject.parseObject(sbuffer.toString());
            } else if (connection.getResponseCode() == 401) {
                result.put("guoqi", "401");
            } else {
                logger.info("请求失败");
            }
            // 断开连接
            connection.disconnect();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }

    /*
     */
    /**
     * post请求
     *
     * @param jsonObject
     * @param url
     * @return
     */
  /*
  public static String postJson(JSONObject jsonObject, String url, String access_token) {
      String body = "";
      CloseableHttpClient client = HttpClients.createDefault();
      HttpPost httpPost = new HttpPost(url);
      StringEntity s = new StringEntity(jsonObject.toString(), "utf-8");
      s.setContentEncoding(new BasicHeader("Content-Type", "application/json"));
      httpPost.setEntity(s);
      httpPost.setHeader("Content-type", "application/json");
      httpPost.addHeader("Authorization", (new StringBuilder()).append("Bearer ").append(access_token).toString());
      httpPost.setHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");
      CloseableHttpResponse response = null;
      try
      {
          response = client.execute(httpPost);
          HttpEntity entity = response.getEntity();
          if(response.getStatusLine().getStatusCode() == 200)
          {
              if(entity != null)
                  body = EntityUtils.toString(entity, "utf-8");
              if(StringUtil.isNullorEmpty(body))
                  body = "success";
          } else
          if(response.getStatusLine().getStatusCode() == 401)
          {
              body = "401";
          } else
          {
              body = "fail";
          }
          EntityUtils.consume(entity);
          response.close();
          return body;
      }
      catch(IOException e)
      {
          e.printStackTrace();
      }
      return null;
  }*/

    /**
     * 向指定URL发送GET方法的请求
     *
     * @param URL   发送请求的URL
     * @param param 请求参数，请求参数应该是 name1=value1&name2=value2 的形式。
     * @return URL 所代表远程资源的响应结果
     */
    public static String doGet(String URL, String param) {
        HttpURLConnection conn;
        InputStream is;
        BufferedReader br;
        StringBuilder result;
        int code;
        conn = null;
        is = null;
        br = null;
        result = new StringBuilder();
        code = 200;
        URL url = null;
        try {
            url = new URL((new StringBuilder()).append(URL).append("?").append(param).toString());
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(15000);
            conn.setReadTimeout(60000);
            conn.setRequestProperty("Accept", "application/json");
            conn.connect();
            if (200 == conn.getResponseCode()) {
                is = conn.getInputStream();
                br = new BufferedReader(new InputStreamReader(is, "UTF-8"));
                String line;
                while ((line = br.readLine()) != null) {
                    result.append(line);
                }
            } else {
                code = conn.getResponseCode();
                System.out.println(
                        (new StringBuilder())
                                .append("ResponseCode is an error code:")
                                .append(conn.getResponseCode())
                                .toString());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            if (br != null) {
                br.close();
            }
            if (is != null) {
                is.close();
            }
        } catch (IOException ioe) {
            ioe.printStackTrace();
        }
        conn.disconnect();
        if (code == 200) {
            return result.toString();
        } else {
            return (new StringBuilder()).append(code).append("").toString();
        }
    }

    /**
     * 发送get请求 返回流
     *
     * @param url 请求地址
     * @return 请求结果
     */
    public static Boolean getFile(String url, String zybh, String endTime, boolean isHttps) {
        Boolean result = Boolean.valueOf(false);
        InputStream inputStream = null;
        try {
            if (isHttps) {
                SSLContext sslcontext = SSLContext.getInstance("TLS");
                sslcontext.init(null, new TrustManager[]{myX509TrustManager}, null);
                URL requestUrl = new URL(url);
                HttpsURLConnection httpsConn = (HttpsURLConnection) requestUrl.openConnection();
                httpsConn.setSSLSocketFactory(sslcontext.getSocketFactory());
                httpsConn.setRequestMethod("GET");
                inputStream = httpsConn.getInputStream();
                int code = httpsConn.getResponseCode();
            } else {
                URL requestUrl = new URL(url);
                HttpURLConnection httpConn = (HttpURLConnection) requestUrl.openConnection();
                httpConn.setRequestMethod("GET");
                inputStream = httpConn.getInputStream();
                String destination =
                        (new StringBuilder())
                                .append(FilePropertiesBase.getRootPath())
                                .append("/yssp/")
                                .append(endTime)
                                .append("#")
                                .append(zybh)
                                .append("_")
                                .append(RandomGUID.getDateUUID())
                                .append(".mp4")
                                .toString();
                if (StringUtil.isNullorEmpty(endTime)) {
                    destination =
                            (new StringBuilder())
                                    .append(FilePropertiesBase.getRootPath())
                                    .append("/yssp/")
                                    .append(zybh)
                                    .append("_")
                                    .append(RandomGUID.getDateUUID())
                                    .append(".mp4")
                                    .toString();
                }
                byte bytes[] = new byte[1024];
                System.out.println(destination);
                FileOutputStream downloadFile = new FileOutputStream(destination);
                int index;
                while ((index = inputStream.read(bytes)) != -1) {
                    downloadFile.write(bytes, 0, index);
                    downloadFile.flush();
                }
                inputStream.close();
                downloadFile.close();
                httpConn.disconnect();
                result = Boolean.valueOf(true);
            }
        } catch (KeyManagementException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (ProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result;
    }

    public static String httpPostWithJson(String url, String json, String authorization) {
        String returnValue = "这是默认返回值，接口调用失败";
        CloseableHttpClient httpClient = HttpClients.createDefault();
        ResponseHandler<String> responseHandler = new BasicResponseHandler();
        try {
            // 第一步：创建HttpClient对象
            httpClient = HttpClients.createDefault();
            // 第二步：创建httpPost对象
            HttpPost httpPost = new HttpPost(url);

            // 第三步：给httpPost设置JSON格式的参数
            StringEntity requestEntity = new StringEntity(json, "utf-8");
            requestEntity.setContentEncoding("UTF-8");
            httpPost.setHeader("Content-type", "application/json");
            httpPost.setHeader("Authorization", authorization);
            httpPost.setEntity(requestEntity);

            // 第四步：发送HttpPost请求，获取返回值
            returnValue = httpClient.execute(httpPost, responseHandler); // 调接口获取返回值时，必须用此方法

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                httpClient.close();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        }
        // 第五步：处理返回值
        return returnValue;
    }
}
