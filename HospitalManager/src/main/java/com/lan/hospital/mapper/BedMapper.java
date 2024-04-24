package com.lan.hospital.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lan.hospital.pojo.Bed;

public interface BedMapper extends BaseMapper<Bed> {
    /**
     * 统计今天住院人数
     */
    int bedPeople(String bStart);
}
