package com.mountaintour.mountain.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/cs")
@Controller
public class CsController {
  
  @GetMapping("/faqList.do")
  public String faqList() {
    return "cs/faqList";
  }

  @GetMapping("/inquiryList.do")
  public String inquiryList() {
    return "cs/inquiryList";
  }
  
}
