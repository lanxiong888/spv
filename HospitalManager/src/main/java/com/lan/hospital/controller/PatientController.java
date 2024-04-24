package com.lan.hospital.controller;

import com.lan.hospital.mapper.OrderMapper;
import com.lan.hospital.pojo.Orders;
import com.lan.hospital.pojo.Patient;
import com.lan.hospital.service.DoctorService;
import com.lan.hospital.service.OrderService;
import com.lan.hospital.service.PatientService;
import com.lan.hospital.utils.JwtUtil;
import com.lan.hospital.utils.PdfUtil;
import com.lan.hospital.utils.ResponseData;
import org.springframework.web.bind.annotation.*;
import redis.clients.jedis.JedisPool;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("patient")
public class PatientController {

    @Resource
    private DoctorService doctorService;
    @Resource
    private PatientService patientService;
    @Resource
    private OrderService orderService;
    @Resource
    private JedisPool jedisPool;
    @Resource
    private OrderMapper orderMapper;

    /**
     * 登录数据验证
     */
    @PostMapping(value = "login")
    @ResponseBody
    public ResponseData login(@RequestParam(value = "pId") int pId, @RequestParam(value = "pPassword") String pPassword) {
        Patient patient = this.patientService.login(pId, pPassword);
        if (patient != null) {
            Map<String,String> map = new HashMap<>();
            map.put("pName", patient.getPName());
            map.put("pId", String.valueOf(patient.getPId()));
            map.put("pCard", patient.getPCard());
            String token = JwtUtil.getToken(map);
            map.put("token", token);
            //response.setHeader("token", token);
            return ResponseData.success("登录成功", map);
        } else {
            return ResponseData.fail("登录失败，密码或账号错误");
        }
    }
    /**
     * 根据科室查询所有医生信息
     */
    @GetMapping("findDoctorBySection")
    public ResponseData findDoctorBySection(@RequestParam(value = "dSection") String dSection){
        return ResponseData.success("根据科室查询所有医生信息成功", this.doctorService.findDoctorBySection(dSection));
    }
    /**
     * 增加挂号信息
     */
    @GetMapping("addOrder")
    @ResponseBody
    public ResponseData addOrder(Orders order, String arId){
        System.out.println(arId);
        if (this.orderService.addOrder(order, arId))
        return ResponseData.success("插入挂号信息成功");
        return ResponseData.fail("插入挂号信息失败");
    }
    /**
     * 根据pId查询挂号
     */
    @GetMapping("findOrderByPid")
    public ResponseData findOrderByPid(@RequestParam(value = "pId") int pId){
        return ResponseData.success("返回挂号信息成功", this.orderService.findOrderByPid(pId)) ;
    }

    /**
     * 增加患者信息
     */
    @GetMapping("addPatient")
    @ResponseBody
    public ResponseData addPatient(Patient patient) {
        Boolean bo = this.patientService.addPatient(patient);
        if (bo) {
            return ResponseData.success("注册成功");
        }
        return ResponseData.fail("注册失败！账号或邮箱已被占用");
    }
    @GetMapping("/pdf")
    public void downloadPDF(HttpServletRequest request, HttpServletResponse response, int oId) throws Exception {
        Orders order = this.orderMapper.findOrderByOid(oId);
        PdfUtil.ExportPdf(request, response, order);
    }
    /**
     * 统计患者男女人数
     */
    @GetMapping("patientAge")
    public ResponseData patientAge(){
        return  ResponseData.success("统计患者男女人数成功", this.patientService.patientAge());

    }
}
