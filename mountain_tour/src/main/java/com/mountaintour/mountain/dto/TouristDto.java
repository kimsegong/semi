package com.mountaintour.mountain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class TouristDto {
  private int touristNo;
  private String name;
  private String birthDate;
  private String gender;
  private String contact;
  private int ageCase;
  private ReserveDto reserveDto; // private int reserveNo;
}
