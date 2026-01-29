// Generated from task1.g4 by ANTLR 4.13.2
import org.antlr.v4.runtime.tree.ParseTreeListener;

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link task1Parser}.
 */
public interface task1Listener extends ParseTreeListener {
	/**
	 * Enter a parse tree produced by the {@code PowerExpr}
	 * labeled alternative in {@link task1Parser#expr}.
	 * @param ctx the parse tree
	 */
	void enterPowerExpr(task1Parser.PowerExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code PowerExpr}
	 * labeled alternative in {@link task1Parser#expr}.
	 * @param ctx the parse tree
	 */
	void exitPowerExpr(task1Parser.PowerExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code MulDivExpr}
	 * labeled alternative in {@link task1Parser#expr}.
	 * @param ctx the parse tree
	 */
	void enterMulDivExpr(task1Parser.MulDivExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code MulDivExpr}
	 * labeled alternative in {@link task1Parser#expr}.
	 * @param ctx the parse tree
	 */
	void exitMulDivExpr(task1Parser.MulDivExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code IdExpr}
	 * labeled alternative in {@link task1Parser#expr}.
	 * @param ctx the parse tree
	 */
	void enterIdExpr(task1Parser.IdExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code IdExpr}
	 * labeled alternative in {@link task1Parser#expr}.
	 * @param ctx the parse tree
	 */
	void exitIdExpr(task1Parser.IdExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code NumberExpr}
	 * labeled alternative in {@link task1Parser#expr}.
	 * @param ctx the parse tree
	 */
	void enterNumberExpr(task1Parser.NumberExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code NumberExpr}
	 * labeled alternative in {@link task1Parser#expr}.
	 * @param ctx the parse tree
	 */
	void exitNumberExpr(task1Parser.NumberExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code ParenExpr}
	 * labeled alternative in {@link task1Parser#expr}.
	 * @param ctx the parse tree
	 */
	void enterParenExpr(task1Parser.ParenExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code ParenExpr}
	 * labeled alternative in {@link task1Parser#expr}.
	 * @param ctx the parse tree
	 */
	void exitParenExpr(task1Parser.ParenExprContext ctx);
	/**
	 * Enter a parse tree produced by the {@code AddSubExpr}
	 * labeled alternative in {@link task1Parser#expr}.
	 * @param ctx the parse tree
	 */
	void enterAddSubExpr(task1Parser.AddSubExprContext ctx);
	/**
	 * Exit a parse tree produced by the {@code AddSubExpr}
	 * labeled alternative in {@link task1Parser#expr}.
	 * @param ctx the parse tree
	 */
	void exitAddSubExpr(task1Parser.AddSubExprContext ctx);
}