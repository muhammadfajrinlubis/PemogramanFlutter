/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.fajrin.Matakuliah.repository;

import com.fajrin.mahasiswa.entity.Matakuliah;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author HP14s FQ2002AU
 */
public interface MatakuliahRepository extends JpaRepository<Matakuliah, Long>{

    public Optional<Matakuliah> findMatakuliahBySks(String sks);

}
