package com.leafbug.todolist;

import static org.junit.Assert.assertTrue;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.leafbug.todolist.dao.BoardDAO;
import com.leafbug.todolist.model.Board;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class BoardDAOImplTest {
	@Autowired
	BoardDAO boardDAO;

	@Test
	public void insertTest() throws Exception {
		Board board = new Board("free", "title", "content", "admin");
		assertTrue(boardDAO.insert(board)==1);
	}

}
