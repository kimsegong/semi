package com.mountaintour.mountain.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.mountaintour.mountain.dto.ProductDto;

public interface ProductService {
  public Map<String, Object> imageUpload(MultipartHttpServletRequest multipartRequest);
  public int addProduct(HttpServletRequest request);
  public List<String> getEditorImageList(String contents);
  public Map<String, Object> getProductList(HttpServletRequest request);
  public ProductDto getProduct(int productNo);
}
