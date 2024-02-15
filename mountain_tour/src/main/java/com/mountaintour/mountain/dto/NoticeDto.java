package com.mountaintour.mountain.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class NoticeDto {

  private int noticeNo;
  private String title;
  private String contents;
  private String createdAt;
  private String modifiedAt;
}