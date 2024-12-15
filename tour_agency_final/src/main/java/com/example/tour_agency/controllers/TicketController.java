package com.example.tour_agency.controllers;
import com.example.tour_agency.repositories.UserRepository;
import com.example.tour_agency.models.Ticket;
import com.example.tour_agency.models.User;
import com.example.tour_agency.services.TicketService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor
public class TicketController {
    private final UserRepository userRepository;
    private final TicketService ticketService;

    @GetMapping("/")
    public String tickets(@RequestParam(name = "depCity", required = false) String depCity,
                           @RequestParam(name = "arrCity", required = false) String arrCity,
                           @RequestParam(name = "minPrice", required = false) Integer minPrice,
                           @RequestParam(name = "maxPrice", required = false) Integer maxPrice,
                           Principal principal,
                           Model model) {


        if (depCity != null && depCity.isEmpty()) {
            depCity = null;
        }
        if (arrCity != null && arrCity.isEmpty()) {
            arrCity = null;
        }

        if (minPrice == null) {
            minPrice = 0;
        }
        if (maxPrice == null) {
            maxPrice = Integer.MAX_VALUE;
        }

        List<Ticket> tickets = ticketService.findByCitiesAndPriceRange(depCity, arrCity, minPrice, maxPrice, ticketService.getUserByPrincipal(principal));

        model.addAttribute("tickets", tickets);
        model.addAttribute("user", ticketService.getUserByPrincipal(principal));
        model.addAttribute("depCity", depCity);
        model.addAttribute("arrCity", arrCity);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);

        return "tickets";
    }



    @PostMapping("/ticket/create")
    public String createTicket(
            @RequestParam("file1") MultipartFile file1,
            @RequestParam(value = "file2", required = false) MultipartFile file2,
            @RequestParam(value = "file3", required = false) MultipartFile file3,
            Ticket ticket,
            Principal principal) throws IOException {
        ticketService.saveTicket(principal, ticket, file1, file2, file3);
        return "redirect:/my/tickets";
    }

    @PostMapping("/ticket/purchase/{id}")
    public String purchaseTicket(@PathVariable Long id, Principal principal) {
        String email = principal.getName(); // Получаем email текущего пользователя
        ticketService.purchaseTicket(id, email);
        return "redirect:/my/tickets";
    }

    @PostMapping("/ticket/delete/{id}")
    public String deleteTicket(@PathVariable Long id, Principal principal) {
        String email = principal.getName();
        ticketService.deleteTicketById(id, email);
        return "redirect:/my/tickets";
    }

    @GetMapping("/my/tickets")
    public String userTickets(Principal principal, Model model) {
        User user = ticketService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        model.addAttribute("tickets", user.getTickets());
        return "my-tickets";
    }

    @GetMapping("/ticket/{id}")
    public String ticketInfo(@RequestParam(name = "showButton", defaultValue = "true") boolean showButton,
                             @PathVariable Long id, Model model, Principal principal) {
        Ticket ticket = ticketService.getTicketById(id);
        User author = ticket.getUser();

        // Добавляем данные в модель
        model.addAttribute("ticket", ticket);
        model.addAttribute("showButton", showButton);
        model.addAttribute("images", ticket.getImages()); // Изображения продукта
        model.addAttribute("authorTicket", author);
        model.addAttribute("user", ticketService.getUserByPrincipal(principal)); // Пользователь, просматривающий страницу

        return "ticket-info";
    }
}
