package com.sliver.service;

import com.github.pagehelper.PageInfo;
import com.sliver.pojo.ApplyBoarder;

public interface ApplyBoarderService {
	int insert(ApplyBoarder applyBorder);

	int approveApply(ApplyBoarder applyBorder, String resaon);

	int refuseApply(ApplyBoarder applyBorder, String reason);

	PageInfo<ApplyBoarder> list(PageInfo<ApplyBoarder> pageInfo);
}
