package com.lan.hospital.controller;

import com.lan.hospital.pojo.Doctor;
import com.lan.hospital.service.DoctorService;
import com.lan.hospital.service.OrderService;
import com.lan.hospital.service.PatientService;
import com.lan.hospital.utils.JwtUtil;
import com.lan.hospital.utils.ResponseData;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("doctor")
public class DoctorController {
    @Resource
    private DoctorService doctorService;
    @Resource
    private OrderService orderService;
    @Resource
    private PatientService patientService;
    /**
     * 登录数据验证
     */
    @PostMapping(value = "login")
    @ResponseBody
    public ResponseData login(@RequestParam(value = "dId") int dId, @RequestParam(value = "dPassword") String dPassword) {
        Doctor doctor = this.doctorService.login(dId, dPassword);
        if (doctor != null) {
            Map<String,String> map = new HashMap<>();
            map.put("dName", doctor.getdName());
            map.put("dId", String.valueOf(doctor.getdId()));
            String token = JwtUtil.getToken(map);
            map.put("token", token);
            //response.setHeader("token", token);
            return ResponseData.success("登录成功", map);
        } else {
            return ResponseData.fail("登录失败，密码或账号错误");
        }
    }
    /**
     * 查看当天挂号列表
     */
    @GetMapping("findOrderByNull")
    public ResponseData findOrderByNull(@Param(value = "dId") int dId, @RequestParam(value = "oStart") String oStart){
        System.out.println("账号时间为"+dId+oStart);
        return ResponseData.success("返回当天挂号信息成功", this.orderService.findOrderByNull(dId,oStart));

    }
    /**
     * 根据患者id查询患者信息
     */
    @GetMapping("findPatientById")
    public ResponseData findPatientById(int pId){
        return ResponseData.success("返回患者信息成功！", this.patientService.findPatientById(pId));
    }
    /**
     * 分页根据科室查询所有医生信息
     */
    @GetMapping("findDoctorBySectionPage")
    public ResponseData findDoctorBySectionPage(int pageNumber, int size, String query, String arrangeDate, String dSection){
        return ResponseData.success("分页根据科室查询所有医生信息成功", this.doctorService.findDoctorBySectionPage(pageNumber, size, query, arrangeDate, dSection));
    }
    /**
     * 用户评价
     */
    @GetMapping("updateStar")
    public ResponseData updateStar(int dId, Double dStar){
        if(this.doctorService.updateStar(dId, dStar))
            return ResponseData.success("评价成功");
        return ResponseData.fail("评价失败");
    }
    /**
     * 上传Excel导入数据
     */
    @PostMapping(value = "uploadExcel")
    @ResponseBody
    public ResponseData uploadExcel(@RequestParam("file") MultipartFile multipartFile) throws Exception {
        if (this.doctorService.uploadExcel(multipartFile))
        return ResponseData.success("上传Excel导入数据成功");
        return ResponseData.fail("上传Excel导入数据失败");

    }
    /**
     * Excel导出数据
     */
    @GetMapping("downloadExcel")
    public ResponseData downloadExcel(HttpServletResponse response) throws IOException {
        if (this.doctorService.downloadExcel(response))
        return ResponseData.success("Excel导出数据成功");
        return ResponseData.fail("Excel导出数据失败");
    }
}
