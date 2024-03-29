/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fajrin.Matakuliah.controller;

import com.fajrin.Matakuliah.entity.Matakuliah;
import com.fajrin.Matakuliah.service.MatakuliahServic;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author HP14s FQ2002AU
 */
@RestController
@RequestMapping("api/v1/Matakuliah")
public class matakuliahcontroller {
    @Autowired
    private MatakuliahServic matakuliahService;
    
    @GetMapping
    public List<Matakuliah> getAll(){
        return matakuliahService.getAll();
    }
    
    @GetMapping(path = "{id}")
    public Matakuliah getMatakuliah(@PathVariable("id") Long id){
        return matakuliahService.getMatakuliah(id); 
    }
}



