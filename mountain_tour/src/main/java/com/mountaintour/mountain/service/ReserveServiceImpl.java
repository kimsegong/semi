package com.mountaintour.mountain.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.gdu.myhome.dto.BlogDto;
import com.mountaintour.mountain.dao.ReserveMapper;
import com.mountaintour.mountain.dto.ReserveDto;
import com.mountaintour.mountain.util.MyPageUtils;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ReserveServiceImpl implements ReserveService{

  private final ReserveMapper reserveMapper;
  private final MyPageUtils myPageUtils;
  
  @Override
  public void loadReserveList(HttpServletRequest request, Model model) {
    
    Optional<String> opt = Optional.ofNullable(request.getParameter("page"));
    int page = Integer.parseInt(opt.orElse("1"));
    int total = reserveMapper.getReserveCount();
    int display = 10;
    
    myPageUtils.setPaging(page, total, display);
    
    Map<String, Object> map = Map.of("begin", myPageUtils.getBegin()
                                   , "end", myPageUtils.getEnd()); 
    
    List<ReserveDto> reserveList = reserveMapper.getReserveList(map);
    
    model.addAttribute("reserveList", reserveList);
    model.addAttribute("paging", myPageUtils.getMvcPaging(request.getContextPath() + "/reserve/list.do"));
    model.addAttribute("beginNo", total - (page - 1) * display);
    
  }
  
}
