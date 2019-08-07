package com.sliver.service;

public interface BasicSetService {
    String getMail();
    void setMail(String adminMail);
    String getFilterString();
    void setFilterString(String filterString);
    void setValue(String setName,String setValue);
    String getValue(String setName);
}
