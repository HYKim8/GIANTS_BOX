package com.uver.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import com.uver.vo.CommentVO;
import com.uver.vo.EventImgVO;
import com.uver.vo.ImgVO;
import com.uver.vo.JoinVO;

@Repository("CommentDaoImpl")
public class CommentDaoImpl implements CommentDao {
	private static final Logger LOG = LoggerFactory.getLogger(CommentDaoImpl.class);

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;

	private final String NAMESPACE = "com.uver.comment";

	public CommentDaoImpl(SqlSessionTemplate sqlSessionTemplate) {
		super();
		this.sqlSessionTemplate = sqlSessionTemplate;
	}

	@Override
	public int doInsert(CommentVO comment) {
		LOG.debug("doInsert");
		String statement = NAMESPACE + ".doInsert";
		int flag = sqlSessionTemplate.insert(statement, comment);
		return flag;
	}

	@Override
	public int doDelete(CommentVO comment) {
		LOG.debug("doDelete");
		String statement = NAMESPACE + ".doDelete";
		int flag = sqlSessionTemplate.delete(statement, comment);
		return flag;
	}

	@Override
	public int doUpdate(CommentVO comment) {
		LOG.debug("doUpdate");
		String statement = NAMESPACE + ".doUpdate";
		int flag = sqlSessionTemplate.update(statement, comment);
		return flag;
	}

	@Override
	public CommentVO doSelectOne(int comment_seq) {
		LOG.debug("doSelectOne");
		String statement = NAMESPACE + ".doSelectOne";
		CommentVO outVO = this.sqlSessionTemplate.selectOne(statement, comment_seq);
		return outVO;
	}

	@Override
	public List<CommentVO> doSelectList(CommentVO comment) {
		LOG.debug("doSelectList");
		String statement = NAMESPACE + ".doSelectList";
		List<CommentVO> list = this.sqlSessionTemplate.selectList(statement, comment);
		for (CommentVO vo : list) {
			LOG.debug("comment" + vo);
		}
		return list;
	}

	@Override
	public int likeCntUp(CommentVO comment) {
		LOG.debug("likeCntUp");
		String statement = NAMESPACE + ".likeCntUp";
		int flag = sqlSessionTemplate.update(statement, comment);
		return flag;
	}

	@Override
	public int likeCntDown(CommentVO comment) {
		LOG.debug("likeCntDown");
		String statement = NAMESPACE + ".likeCntDown";
		int flag = sqlSessionTemplate.update(statement, comment);
		return flag;
	}

}

// jdbcTemplate을 이용한 dao 처리
/*
 * // -----row mapper RowMapper<CommentVO> rowMapper = new
 * RowMapper<CommentVO>() { public CommentVO mapRow(ResultSet rs, int rowNum)
 * throws SQLException { CommentVO outVO = new
 * CommentVO(rs.getInt("comment_seq"), rs.getInt("seq"), rs.getString("div"),
 * rs.getString("content"), rs.getString("reg_dt"), rs.getString("reg_id"),
 * rs.getString("mod_dt"), rs.getInt("like_cnt")); return outVO; }
 * 
 * }; // ---row mapper end
 * 
 * // -----메서드
 * 
 * @Override public int doInsert(CommentVO comment) { int flag = 0; Object[]
 * args = { comment.getSeq(), comment.getDiv(), comment.getContent(),
 * comment.getRegId() };
 * 
 * StringBuilder sb = new StringBuilder();
 * sb.append("INSERT INTO comment_tb (	\n");
 * sb.append("    comment_seq,         \n");
 * sb.append("    seq,                 \n");
 * sb.append("    div,                 \n");
 * sb.append("    content,             \n");
 * sb.append("    reg_dt,              \n");
 * sb.append("    reg_id,              \n");
 * sb.append("    mod_dt,              \n");
 * sb.append("    like_cnt              \n");
 * sb.append(") VALUES (               \n");
 * sb.append("    COMMENT_SEQ.NEXTVAL, \n");
 * sb.append("    ?,                   \n");
 * sb.append("    ?,                   \n");
 * sb.append("    ?,                   \n");
 * sb.append("    SYSDATE,             \n");
 * sb.append("    ?,                   \n");
 * sb.append("    SYSDATE,             \n"); sb.append("    ?            \n");
 * sb.append(")                        \n");
 * LOG.debug("-----------------------------"); LOG.debug("[SQL]\n" +
 * sb.toString()); LOG.debug("[param]\n" + comment);
 * LOG.debug("-----------------------------");
 * 
 * flag = this.jdbcTemplate.update(sb.toString(), args); LOG.debug("[flag] " +
 * flag);
 * 
 * return flag; }
 * 
 * @Override public int doDelete(CommentVO vo) { int flag = 0;
 * 
 * StringBuilder sb = new StringBuilder();
 * sb.append("DELETE FROM comment_tb  \n");
 * sb.append("WHERE                   \n");
 * sb.append("    comment_seq = ?     \n");
 * 
 * Object[] args = { vo.getCommentSeq() }; flag =
 * this.jdbcTemplate.update(sb.toString(), args); LOG.debug("=flag=" + flag);
 * 
 * return flag; }
 * 
 * @Override public int doUpdate(CommentVO vo) { int flag = 0; StringBuilder sb
 * = new StringBuilder(); sb.append("UPDATE comment_tb	 \n");
 * sb.append("SET                   \n"); sb.append("    content = ?,      \n");
 * sb.append("    mod_dt = SYSDATE  \n"); sb.append("WHERE                 \n");
 * sb.append("    comment_seq = ?   \n"); LOG.debug("=param=" + vo);
 * LOG.debug("========================");
 * 
 * Object[] args = { vo.getContent(), vo.getCommentSeq() }; flag =
 * this.jdbcTemplate.update(sb.toString(), args); LOG.debug("=flag=" + flag);
 * return flag; }
 * 
 * @Override public CommentVO doSelectOne(int comment_seq) { CommentVO outVO =
 * null;
 * 
 * StringBuilder sb = new StringBuilder(); sb.append("SELECT			   \n");
 * sb.append("    comment_seq,    \n"); sb.append("    seq,            \n");
 * sb.append("    div,            \n"); sb.append("    content,        \n");
 * sb.append("    TO_CHAR(reg_dt, 'YY/MM/DD HH24:MI:SS') AS reg_dt,         \n"
 * ); sb.append("    reg_id,         \n");
 * sb.append("    TO_CHAR(mod_dt, 'YY/MM/DD HH24:MI:SS') AS mod_dt          \n"
 * ); sb.append("FROM                \n"); sb.append("    comment_tb      \n");
 * sb.append("WHERE comment_seq=? \n");
 * 
 * Object[] args = { comment_seq }; outVO = (CommentVO)
 * this.jdbcTemplate.queryForObject(sb.toString(), args, rowMapper);
 * 
 * LOG.debug("====================================="); LOG.debug("=outVO=" +
 * outVO); LOG.debug("=====================================");
 * 
 * return outVO;
 * 
 * }
 * 
 * @Override public List<CommentVO> doSelectList(CommentVO vo) { List<CommentVO>
 * list = null; LOG.debug("dao"); Object[] args = { vo.getSeq(), vo.getDiv() };
 * StringBuilder sb = new StringBuilder();
 * sb.append("SELECT												\n");
 * sb.append("    comment_seq,                                     \n");
 * sb.append("    seq,                                             \n");
 * sb.append("    div,                                             \n");
 * sb.append("    content,                                         \n");
 * sb.append("    TO_CHAR(reg_dt, 'YY/MM/DD HH24:MI:SS') AS reg_dt,  \n");
 * sb.append("    reg_id,                                          \n");
 * sb.append("    TO_CHAR(mod_dt, 'YY/MM/DD HH24:MI:SS') AS mod_dt   \n");
 * sb.append("FROM                                                 \n");
 * sb.append("    comment_tb                                       \n");
 * sb.append("WHERE seq=?                                          \n");
 * sb.append("AND div=?                                            \n");
 * sb.append("ORDER BY mod_dt desc                                \n");
 * 
 * list = (List<CommentVO>) this.jdbcTemplate.query(sb.toString(), args,
 * rowMapper);
 * 
 * for (CommentVO comment : list) { LOG.debug("[comment] " + comment); }
 * 
 * return list; }
 * 
 * }
 */