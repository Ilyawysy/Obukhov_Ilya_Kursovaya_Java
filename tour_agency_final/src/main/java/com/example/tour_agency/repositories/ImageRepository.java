package com.example.tour_agency.repositories;

import com.example.tour_agency.models.Image;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<Image, Long> {
}
