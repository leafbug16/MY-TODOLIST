package com.leafbug.todolist.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.leafbug.todolist.model.Comment;

@Repository
public class CommentDAOImpl implements CommentDAO {
	@Autowired
	SqlSession session;
	
	String namespace = "commentMapper.";
	
	@Override
	public int count(Integer bno) throws Exception {
		return session.selectOne(namespace+"count", bno);
	}
	
	@Override
	public List<Comment> selectAll(Integer bno) throws Exception {
		return session.selectList(namespace+"selectAll", bno);
	}
	
	@Override
	public Comment select(Integer cno) throws Exception {
		return session.selectOne(namespace+"select", cno);
	}
	
	@Override
	public int insert(Comment comment) throws Exception {
		return session.insert(namespace+"insert", comment);
	}
	
	@Override
	public int update(Comment comment) throws Exception {
		return session.update(namespace+"update", comment);
	}
	
	@Override
	public int deleteAll(Integer bno) throws Exception {
		return session.delete(namespace+"deleteAll", bno);
	}
	
	@Override
	public int delete(Integer cno) throws Exception {
		Map map = new HashMap();
		map.put("cno", cno);
		return session.delete(namespace+"delete", map);
	}
	
}









































