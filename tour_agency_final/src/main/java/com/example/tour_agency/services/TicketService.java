package com.example.tour_agency.services;

import com.example.tour_agency.models.Image;
import com.example.tour_agency.models.Ticket;
import com.example.tour_agency.models.User;
import com.example.tour_agency.repositories.TicketRepository;
import com.example.tour_agency.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.el.parser.AstFalse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.transaction.Transactional;
import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class TicketService {

    @Autowired
    private TicketRepository ticketRepository;


    public List<Ticket> findByCitiesAndPriceRange(String depCity, String arrCity, Integer minPrice, Integer maxPrice, User user) {

        List<Ticket> filteredTickets;
        List<Ticket> userTickets = new ArrayList<>();
        if (!user.isAdmin()) {
            userTickets = user.getTickets();
        }

        if (depCity == null && arrCity == null) {
            filteredTickets = ticketRepository.findByPriceBetween(minPrice, maxPrice);
            filteredTickets.removeIf(userTickets::contains);
            return filteredTickets;
        }
        if (depCity == null) {
            filteredTickets = ticketRepository.findByArrCityAndPriceBetween(arrCity, minPrice, maxPrice);
            filteredTickets.removeIf(userTickets::contains);
            return filteredTickets;
        }
        if (arrCity == null) {
            filteredTickets = ticketRepository.findByDepCityAndPriceBetween(depCity, minPrice, maxPrice);
            filteredTickets.removeIf(userTickets::contains);
            return filteredTickets;
        }
        filteredTickets = ticketRepository.findByDepCityAndArrCityAndPriceBetween(depCity, arrCity, minPrice, maxPrice);
        filteredTickets.removeIf(userTickets::contains);
        return filteredTickets;
    }

    public void saveTicket(Principal principal, Ticket ticket, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException {
        ticket.setUser(getUserByPrincipal(principal));

        if (file1 != null && file1.getSize() != 0) {
            Image image1 = toImageEntity(file1);
            image1.setPreviewImage(true);
            ticket.addImageToTicket(image1);
        }

        if (file2 != null && file2.getSize() != 0) {
            Image image2 = toImageEntity(file2);
            image2.setPreviewImage(false);
            ticket.addImageToTicket(image2);
        }

        if (file3 != null && file3.getSize() != 0) {
            Image image3 = toImageEntity(file3);
            image3.setPreviewImage(false);
            ticket.addImageToTicket(image3);
        }

        log.info("Saving new Product. Title: {}; Author email: {}", ticket.getTitle(), ticket.getUser().getEmail());

        Ticket ticketFromDb = ticketRepository.save(ticket);
        if (!ticketFromDb.getImages().isEmpty()) {
            ticketFromDb.setPreviewImageId(ticketFromDb.getImages().get(0).getId());
        }
        ticketRepository.save(ticketFromDb);
    }


    @Autowired
    private UserRepository userRepository;

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }


    public void purchaseTicket(Long id, String userEmail) {

        Ticket ticket = ticketRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Ticket not found"));

        User user = userRepository.findByEmail(userEmail);

        if (ticket.getUser() == null || !ticket.getUser().isAdmin()) {
            throw new RuntimeException("Ticket is not available for purchase");
        }

        ticket.setUser(user);
        ticketRepository.save(ticket);
    }

    @Transactional
    public void deleteTicketById(Long id, String userEmail) {
        Ticket ticket = ticketRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Ticket not found"));

        User user = userRepository.findByEmail(userEmail);

        if (user.isAdmin()) {
            ticketRepository.delete(ticket);
        } else {
            ticket.setUser(userRepository.findByEmail("admin@admin.ru")); // Передача билета пользователю
            ticketRepository.save(ticket);
        }
    }

    public Ticket getTicketById(Long id) {
        return ticketRepository.findById(id).orElse(null);
    }
}
