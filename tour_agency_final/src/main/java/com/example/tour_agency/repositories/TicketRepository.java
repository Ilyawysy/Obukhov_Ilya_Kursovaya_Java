package com.example.tour_agency.repositories;

import com.example.tour_agency.models.Ticket;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TicketRepository extends JpaRepository<Ticket, Long> {

    List<Ticket> findByPriceBetween(Integer minPrice, Integer maxPrice);

    List<Ticket> findByArrCityAndPriceBetween(String arrCity, Integer minPrice, Integer maxPrice);

    List<Ticket> findByDepCityAndPriceBetween(String depCity, Integer minPrice, Integer maxPrice);

    List<Ticket> findByDepCityAndArrCityAndPriceBetween(String depCity, String arrCity, Integer minPrice, Integer maxPrice);
}




