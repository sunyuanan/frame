package com.example.frame.common.faceComparison;

import com.example.frame.common.utils.DataResult;
import com.tencentcloudapi.common.Credential;
import com.tencentcloudapi.common.exception.TencentCloudSDKException;
import com.tencentcloudapi.common.profile.ClientProfile;
import com.tencentcloudapi.common.profile.HttpProfile;
import com.tencentcloudapi.iai.v20200303.IaiClient;
import com.tencentcloudapi.iai.v20200303.models.*;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author sya
 * Created by Administrator on 2021/10/28 0028 15:01
 */
@Service
public class CompareFaceApi {

    final String secretId = "AKIDjEXaBWaalaAVbSuXw8JE7l9aliPXt8gz";
    final String secretKey = "4RdfOuqY0D7nFUR1QPCVHrFQRM6JI2EA";

    Credential cred = null;
    IaiClient client = null;


    public CompareFaceApi() {
        // 实例化一个认证对象，入参需要传入腾讯云账户secretId，secretKey,此处还需注意密钥对的保密
        // 密钥可前往https://console.cloud.tencent.com/cam/capi网站进行获取
        cred = new Credential(secretId, secretKey);
        // 实例化一个http选项，可选的，没有特殊需求可以跳过
        HttpProfile httpProfile = new HttpProfile();
        httpProfile.setEndpoint("iai.tencentcloudapi.com");
        // 实例化一个client选项，可选的，没有特殊需求可以跳过
        ClientProfile clientProfile = new ClientProfile();
        clientProfile.setHttpProfile(httpProfile);
        // 实例化要请求产品的client对象,clientProfile是可选的
        client = new IaiClient(cred, "ap-beijing", clientProfile);
    }

    /**
     * 人员搜索
     *
     * @param groupIds  人员库ID List
     * @param imgBase64 base64图片
     * @return
     */
    public DataResult searchFaces(ArrayList groupIds, String imgBase64) {
        try {

            SearchFacesRequest req = new SearchFacesRequest();

            req.set("GroupIds", groupIds);
            req.setImage(imgBase64);

            // 返回的resp是一个CompareFaceResponse的实例，与请求对象对应
            SearchFacesResponse resp = client.SearchFaces(req);
            // 输出json格式的字符串回包
            return DataResult.success(CompareFaceResponse.toJsonString(resp));
        } catch (TencentCloudSDKException e) {
            return DataResult.fail(e.toString());
        }
    }

    /**
     * 新增人员库
     *
     * @param groupName 分组库名
     * @param groupId   分组库ID
     * @return
     */
    public DataResult createGroupRequest(String groupName, String groupId) {
        try {
            CreateGroupRequest req = new CreateGroupRequest();

            req.setGroupName(groupName);
            req.setGroupId(groupId);

            // 返回的resp是一个CreateGroupResponse的实例，与请求对象对应
            CreateGroupResponse resp = client.CreateGroup(req);
            // 输出json格式的字符串回包
            return DataResult.success(CreateGroupResponse.toJsonString(resp));
        } catch (TencentCloudSDKException e) {
            return DataResult.fail(e.toString());
        }

    }

    /**
     * 新增人员
     *
     * @param groupId    分组库ID
     * @param personName 人名
     * @param gender     性别（0代表未填写，1代表男性，2代表女性。）
     * @param imgBase64  imgBase64 base64图片
     * @return
     */

    public DataResult createPersonRequest(String groupId, String personName, String personId, Integer gender, String imgBase64) {
        try {
            CreatePersonRequest req = new CreatePersonRequest();

            req.setGroupId(groupId);
            req.setPersonName(personName);
            req.setPersonId(personId);
            req.setGender(gender.longValue());
            req.setImage(imgBase64);

            // 返回的resp是一个CreatePersonResponse的实例，与请求对象对应
            CreatePersonResponse resp = client.CreatePerson(req);


            return DataResult.success(CreatePersonResponse.toJsonString(resp));
        } catch (TencentCloudSDKException e) {
            return DataResult.fail(e.toString());
        }
    }

    /**
     * 新增人脸
     *
     * @param personId  人员ID
     * @param imgBase64
     * @return
     */
    public DataResult createFaceRequest(String personId, List imgBase64) {
        try {
            CreateFaceRequest req = new CreateFaceRequest();

            req.setPersonId(personId);
            req.set("Images", imgBase64);

            // 返回的resp是一个CreateFaceResponse的实例，与请求对象对应
            CreateFaceResponse resp = client.CreateFace(req);

            // 输出json格式的字符串回包
            return DataResult.success(CreateFaceResponse.toJsonString(resp));
        } catch (TencentCloudSDKException e) {
            return DataResult.fail(e.toString());
        }
    }

    /**
     * 人脸验证
     *
     * @param personId  人员ID
     * @param imgBase64
     * @return
     */
    public DataResult verifyFaceRequest(String personId, String imgBase64) {
        try {
            VerifyFaceRequest req = new VerifyFaceRequest();
            req.setImage(imgBase64);
            req.setPersonId(personId);
            // 返回的resp是一个VerifyFaceResponse的实例，与请求对象对应
            VerifyFaceResponse resp = client.VerifyFace(req);

            // 输出json格式的字符串回包
            return DataResult.success(VerifyFaceResponse.toJsonString(resp));
        } catch (TencentCloudSDKException e) {
            return DataResult.fail(e.toString());
        }
    }

    /**
     * 人脸比对
     *
     * @param imageA
     * @param imageB
     * @return
     */
    public DataResult compareFaceRequest(String imageA, String imageB) {
        try {

            CompareFaceRequest req = new CompareFaceRequest();
            req.setImageA(imageA);
            req.setImageB(imageB);
            // 返回的resp是一个CreateFaceResponse的实例，与请求对象对应
            CompareFaceResponse resp = client.CompareFace(req);

            // 输出json格式的字符串回包
            return DataResult.success(CompareFaceResponse.toJsonString(resp));
        } catch (TencentCloudSDKException e) {
            return DataResult.fail(e.toString());
        }
    }


    /**
     * 删除人员
     *
     * @param personId 人员Id
     * @return
     */
    public DataResult deletePersonRequest(String personId) {
        try {
            DeletePersonRequest req = new DeletePersonRequest();
            req.setPersonId(personId);
            DeletePersonResponse resp = client.DeletePerson(req);
            return DataResult.success(DeletePersonResponse.toJsonString(resp));
        } catch (TencentCloudSDKException e) {
            return DataResult.fail(e.toString());
        }
    }


    /**
     * 删除人脸
     *
     * @param personId 人员ID
     * @param faceIds  人脸ID List
     * @return
     */
    public DataResult deleteFaceRequest(String personId, List faceIds) {
        try {
            DeleteFaceRequest req = new DeleteFaceRequest();

            req.setPersonId(personId);
            req.set("FaceIds", faceIds);

            // 返回的resp是一个DeleteFaceResponse的实例，与请求对象对应
            DeleteFaceResponse resp = client.DeleteFace(req);
            return DataResult.success(DeleteFaceResponse.toJsonString(resp));
        } catch (TencentCloudSDKException e) {
            return DataResult.fail(e.toString());
        }
    }


}
