/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.fajrin.Matakuliah.service;

import com.fajrin.mahasiswa.entity.Matakuliah;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.fajrin.Matakuliah.repository.MatakuliahRepository;
import java.util.Optional;

/**
 *
 * @author HP14s FQ2002AU
 */
@Service
public class MatakuliahServic {
    private final MatakuliahRepository matakuliahRepository;
    
    @Autowired
    public MatakuliahServic(MatakuliahRepository MatakuliahRepository){
        this.matakuliahRepository = MatakuliahRepository;
    }
    
    public List<Matakuliah>getAll(){
        return matakuliahRepository.findAll();
    }
    
    public void insert(Matakuliah matakuliah){
        Optional<Matakuliah>MatakuliahOptional =
                matakuliahRepository.findMatakuliahBySks(matakuliah.getSks());
         if(MatakuliahOptional.isPresent()){
               throw new IllegalStateException("sks sudah ada");
           }
          matakuliahRepository.save(matakuliah);
       }
    
}
