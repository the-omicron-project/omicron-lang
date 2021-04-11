require "./token"
require "./expression"

module Omicron
  abstract class Statement
    class Expression < Statement
      property :expression

      @expression : Omicron::Expression

      def initialize(expression : Omicron::Expression)
        @expression = expression
      end

      def accept(visitor)
        visitor.visit_expression_statement(self)
      end
    end

    class Print < Statement
      property :expression

      @expression : Omicron::Expression

      def initialize(expression : Omicron::Expression)
        @expression = expression
      end

      def accept(visitor)
        visitor.visit_print_statement(self)
      end
    end

    class Var < Statement
      property :name
      property :initializer

      @name : Token
      @initializer : Omicron::Expression?

      def initialize(name : Token, initializer : Omicron::Expression?)
        @name = name
        @initializer = initializer
      end

      def accept(visitor)
        visitor.visit_var_statement(self)
      end
    end

    class Block < Statement
      property :statements

      @statements : Array(Statement)

      def initialize(statements : Array(Statement))
        @statements = statements
      end

      def accept(visitor)
        visitor.visit_block_statement(self)
      end
    end

    class If < Statement
      property :condition
      property :then_branch
      property :else_branch

      @condition : Omicron::Expression
      @then_branch : Statement
      @else_branch : Statement?

      def initialize(condition : Omicron::Expression, then_branch : Statement, else_branch : Statement?)
        @condition = condition
        @then_branch = then_branch
        @else_branch = else_branch
      end

      def accept(visitor)
        visitor.visit_if_statement(self)
      end
    end

    class While < Statement
      property :condition
      property :body

      @condition : Omicron::Expression
      @body : Statement

      def initialize(condition : Omicron::Expression, body : Statement)
        @condition = condition
        @body = body
      end

      def accept(visitor)
        visitor.visit_while_statement(self)
      end
    end

    class Function < Statement
      property :name
      property :params
      property :body

      @name : Token
      @params : Array(Token)
      @body : Array(Statement)

      def initialize(name : Token, params : Array(Token), body : Array(Statement))
        @name = name
        @params = params
        @body = body
      end

      def accept(visitor)
        visitor.visit_function_statement(self)
      end
    end

    class Return < Statement
      property :keyword
      property :value

      @keyword : Token
      @value : Omicron::Expression?

      def initialize(keyword : Token, value : Omicron::Expression?)
        @keyword = keyword
        @value = value
      end

      def accept(visitor)
        visitor.visit_return_statement(self)
      end
    end
  end
end
