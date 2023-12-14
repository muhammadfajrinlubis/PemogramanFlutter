/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fajrin.Matakuliah.service;

import com.fajrin.Matakuliah.entity.Matakuliah;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fajrin.Matakuliah.repository.MatakuliahRepository;


/**
 *
 * @author HP14s FQ2002AU
 */
@Service
public class MatakuliahServic {
    @Autowired
    private MatakuliahRepository matakuliahRepository;
    
    public List<Matakuliah> getAll(){
        return matakuliahRepository.findAll();
    }
    
    public Matakuliah getMatakuliah(Long idmatakuliah){
        return matakuliahRepository.findById(idmatakuliah).get();
    } 
}