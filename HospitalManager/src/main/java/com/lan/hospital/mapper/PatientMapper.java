package com.lan.hospital.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lan.hospital.pojo.Patient;
import org.apache.ibatis.annotations.Param;

public interface PatientMapper extends BaseMapper<Patient> {
    /**
     * 统计患者男女人数
     */
    Integer patientAge(@Param("startAge") int startAge, @Param("endAge") int endAge);
}
