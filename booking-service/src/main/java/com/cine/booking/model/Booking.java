package com.cine.booking.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "bookings")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Booking {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private Long userId;
    private Long movieId;
    private String movieTitle;
    private Integer numberOfSeats;
    private Double totalPrice;
    private LocalDateTime showTime;
    private String status;
    private LocalDateTime bookingDate;
}
