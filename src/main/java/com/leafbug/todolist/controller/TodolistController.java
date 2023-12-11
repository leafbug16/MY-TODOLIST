package com.leafbug.todolist.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.leafbug.todolist.model.Memo;
import com.leafbug.todolist.model.Todo;
import com.leafbug.todolist.model.Todolist;
import com.leafbug.todolist.model.User;
import com.leafbug.todolist.service.TodolistService;
import com.leafbug.todolist.service.UserService;

@Controller
@RequestMapping("/todolist")
public class TodolistController {
	@Autowired
	TodolistService ts;
	@Autowired
	UserService us;
	
	//todolist.jsp 띄우는 용도
	@GetMapping("/main")
	public String main(HttpSession session, Model m) {
		m.addAttribute("sessionId", session.getAttribute("id")+"");
		return "todolist3";
	}
	
	//todolist2.jsp 공사중
	//특정 목록 할일 모두 조회
	@GetMapping("/mainTodos")
	@ResponseBody
	public ResponseEntity<List<Todo>> mainTodos(HttpSession session) {
		List<Todo> todoLists = null;
		Todo todo = new Todo();
		todo.setUserId(session.getAttribute("id")+"");
		try {
			todoLists = ts.getMainTodos(todo);
			return new ResponseEntity<List<Todo>>(todoLists, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<Todo>>(todoLists, HttpStatus.BAD_REQUEST);
	}
	
	//메모 가져오기
	@GetMapping("/todosMainMemo")
	@ResponseBody
	public ResponseEntity<User> todosMainMemo(HttpSession session) {
		User user = new User();
		Map map = new HashMap();
		map.put("id", session.getAttribute("id")+"");
		try {
			user = us.getMainMemo(map);
			return new ResponseEntity<User>(user, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<User>(user, HttpStatus.BAD_REQUEST);
		}
	}
	
	//메모 입력하기
	@PostMapping("/todosMainMemo")
	@ResponseBody
	public ResponseEntity<String> todosMainMemo(@RequestBody User user, HttpSession session) {
		try {
			int res = us.modifyMainMemo(user);
			if(res != 1) throw new Exception("Memo Write Error");
			return new ResponseEntity<>("MEMO_WRITE_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("MEMO_WRITE_ERR", HttpStatus.BAD_REQUEST);
		}
	}

	//todolist2.jsp 공사 끝
	
	//목록 가져오기(ajax)
	@GetMapping("/lists")
	@ResponseBody
	public ResponseEntity<List<Todolist>> lists(HttpSession session, Model m) {
		List<Todolist> lists = null;
		Todolist todolist = new Todolist();
		todolist.setUserId(session.getAttribute("id")+"");
		m.addAttribute("sessionId", session.getAttribute("id")+"");
		try {
			lists = ts.getLists(todolist);	
			return new ResponseEntity<List<Todolist>>(lists, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<List<Todolist>>(lists, HttpStatus.BAD_REQUEST);
		}
	}
	
	//목록 하나 클릭(read)
	@GetMapping("/read")
	public String read(Integer lno, HttpSession session, Model m) {	
		List<Todolist> lists = null;
		Todolist todolist = new Todolist();
		todolist.setUserId(session.getAttribute("id")+"");
		m.addAttribute("sessionId", session.getAttribute("id")+"");
		try {
			lists = ts.getLists(todolist);
			m.addAttribute("lists", lists);
			
			todolist = ts.getlist(lno);
			m.addAttribute("tl", todolist);
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/todolist/main";
		}
		return "todolistView";
	}
	
	//할일목록 추가 ajax
	@PostMapping("/lists")
	@ResponseBody
	public ResponseEntity<String> write(HttpSession session) {
		Todolist todolist = new Todolist();
		todolist.setUserId(session.getAttribute("id")+"");
		try {
			int res = ts.write(todolist);
			if(res != 1) throw new Exception("Write List Error");
			return new ResponseEntity<>("LIST_WRITE_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("LIST_WRITE_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	//할일목록 제목 수정 ajax
	@PatchMapping("/lists")
	@ResponseBody
	public ResponseEntity<String> modifyLists(@RequestBody Todolist todolist, HttpSession session) {
		try {
			int res = ts.modify(todolist);
			if(res != 1) throw new Exception("List Modify Error");
			return new ResponseEntity<>("LIST_MODIFY_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("LIST_MODIFY_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	//할일 목록 하나 삭제
	@DeleteMapping("/lists")
	@ResponseBody
	public ResponseEntity<String> removeList(@RequestParam Integer lno, HttpSession session) {
		Todolist todolist = new Todolist();
		todolist.setLno(lno);
		Todo todo = new Todo();
		todo.setLno(lno);
		try {
			int res = ts.remove(todolist);
			int res1 = ts.removeTodoAll(todo);
			if(res != 1 && res1 != 1) throw new Exception("List Delete Error");
			return new ResponseEntity<>("LIST_DELETE_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("LIST_DELETE_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	//할일 목록 전체 삭제
	@DeleteMapping("/listsAll")
	@ResponseBody
	public ResponseEntity<String> removeListAll(HttpSession session) {
		Todolist todolist = new Todolist();
		todolist.setUserId(session.getAttribute("id")+"");
		try {
			int res = ts.removeAll(todolist);
			int res1 = ts.removeAllTodoAll(todolist);
			if(res < 1) throw new Exception("List Delete Error");
			return new ResponseEntity<>("LIST_DELETE_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("LIST_DELETE_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	//목록 끝 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//특정 목록 할일 모두 조회
	@GetMapping("/todos")
	@ResponseBody
	public ResponseEntity<List<Todo>> todos(@RequestParam Integer lno) {
		List<Todo> todoLists = null;
		Todo todo = new Todo();
		todo.setLno(lno);
		try {
			todoLists = ts.getTodoLists(todo);
			return new ResponseEntity<List<Todo>>(todoLists, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<List<Todo>>(todoLists, HttpStatus.BAD_REQUEST);
	}
	
	//할일 추가
	@PostMapping("/todos")
	@ResponseBody
	public ResponseEntity<String> writeTodos(@RequestBody Todo todo, HttpSession session) {
		todo.setUserId(session.getAttribute("id")+"");
		try {
			int res = ts.writeTodo(todo);
			if(res != 1) throw new Exception("Write Error");
			return new ResponseEntity<>("WRITE_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("WRITE_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	//할일 수정
	@PatchMapping("/todos")
	@ResponseBody
	public ResponseEntity<String> modifyTodos(@RequestBody Todo todo, HttpSession session) {
		try {
			int res = ts.modifyTodo(todo);
			if(res != 1) throw new Exception("Modify Error");
			return new ResponseEntity<>("MODIFY_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("MODIFY_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	//할일 삭제
	@DeleteMapping("/todos")
	@ResponseBody
	public ResponseEntity<String> removeTodos(@RequestParam Integer tno, HttpSession session) {
		Todo todo = new Todo();
		todo.setTno(tno);
		try {
			int res = ts.removeTodo(todo);
			if(res != 1) throw new Exception("Delete Error");
			return new ResponseEntity<>("DELETE_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("DELETE_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	//할일 전체삭제
	//할일 목록 전체 삭제
	@DeleteMapping("/todoListsAll")
	@ResponseBody
	public ResponseEntity<String> removeTodoListsAll(@RequestParam Integer lno, HttpSession session) {
		Todo todo = new Todo();
		todo.setLno(lno);
		try {
			int res = ts.removeTodoAll(todo);
			if(res < 1) throw new Exception("Todolist Delete Error");
			return new ResponseEntity<>("TODO_LIST_DELETE_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("TODO_LIST_DELETE_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	//할일 끝 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//메모 가져오기
	@GetMapping("/todosMemo")
	@ResponseBody
	public ResponseEntity<Todolist> todosMemo(@RequestParam Integer lno) {
		long startTime = System.currentTimeMillis();
		Todolist todolist = new Todolist();
		Map map = new HashMap();
		map.put("lno", lno);
		try {
			todolist = ts.getMemo(map);
			long endTime = System.currentTimeMillis();
			long durationTimeSec = endTime - startTime;
			System.out.println(durationTimeSec + "m/s"); // 밀리세컨드 출력
			return new ResponseEntity<Todolist>(todolist, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Todolist>(todolist, HttpStatus.BAD_REQUEST);
		}
	}
	
	//메모 입력하기
	@PostMapping("/todosMemo")
	@ResponseBody
	public ResponseEntity<String> writeTodosMemo(@RequestBody Todolist todolist, HttpSession session) {
		try {
			int res = ts.modifyMemo(todolist);
			if(res != 1) throw new Exception("Memo Write Error");
			return new ResponseEntity<>("MEMO_WRITE_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("MEMO_WRITE_ERR", HttpStatus.BAD_REQUEST);
		}
		
	}
	
	//할일 세팅 시작 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
	//endDate 입력하기
	@PatchMapping("/endDate")
	@ResponseBody
	public ResponseEntity<String> modifyEndDate(@RequestBody Todo todo, HttpSession session) {
		try {
			int res = ts.modifyEndDate(todo);
			if(res != 1) throw new Exception("endDate Modify Error");
			return new ResponseEntity<>("ENDDATE_MODIFY_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("ENDDATE_MODIFY_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	@PatchMapping("/dday")
	@ResponseBody
	public ResponseEntity<Todo> modifyDday(@RequestBody Todo todo, HttpSession session) {
		try {
			int res = ts.modifyDday(todo);
			if(res != 1) throw new Exception("dday Modify Error");
			return new ResponseEntity<Todo>(todo, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Todo>(todo, HttpStatus.BAD_REQUEST);
		}
	}
	
	@PatchMapping("/dplusday")
	@ResponseBody
	public ResponseEntity<Todo> modifyDplusday(@RequestBody Todo todo, HttpSession session) {
		try {
			int res = ts.modifyDplusday(todo);
			if(res != 1) throw new Exception("dplusday Modify Error");
			return new ResponseEntity<Todo>(todo, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Todo>(todo, HttpStatus.BAD_REQUEST);
		}
	}
	
	@PatchMapping("/startend")
	@ResponseBody
	public ResponseEntity<Todo> modifyStartend(@RequestBody Todo todo, HttpSession session) {
		try {
			int res = ts.modifyStartend(todo);
			if(res < 1) throw new Exception("startend Modify Error");
			return new ResponseEntity<Todo>(todo, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Todo>(todo, HttpStatus.BAD_REQUEST);
		}
	}
	
	@PatchMapping("/repeat")
	@ResponseBody
	public ResponseEntity<Todo> modifyRepeat(@RequestBody Todo todo, HttpSession session) {
		try {
			int res = ts.modifyRepeat(todo);
			if(res < 1) throw new Exception("startend Modify Error");
			return new ResponseEntity<Todo>(todo, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<Todo>(todo, HttpStatus.BAD_REQUEST);
		}
	}
	
	//complete 수정하기
	@PatchMapping("/complete")
	@ResponseBody
	public ResponseEntity<String> modifyComplete(@RequestBody Todo todo, HttpSession session) {
		try {
			int res = ts.modifyComplete(todo);
			if (todo.getCompleteDate() != null) {
				int res1 = ts.modifyCompletes(todo);
			}
			if(res != 1) throw new Exception("Complete Modify Error");
			return new ResponseEntity<>("COMPLETE_MODIFY_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("COMPLETE_MODIFY_ERR", HttpStatus.BAD_REQUEST);
		}
	}
	
	//상세메모 수정하기
	@PostMapping("/todosAdditionalMemo")
	@ResponseBody
	public ResponseEntity<String> writeTodosAdditionalMemo(@RequestBody Todo todo, HttpSession session) {
		try {
			int res = ts.modifyAdditionalMemo(todo);
			if(res != 1) throw new Exception("AdditionalMemo Write Error");
			return new ResponseEntity<>("ADDITIONAL_MEMO_WRITE_OK", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>("ADDITIONAL_MEMO_WRITE_ERR", HttpStatus.BAD_REQUEST);
		}
		
	}
	
	
}































