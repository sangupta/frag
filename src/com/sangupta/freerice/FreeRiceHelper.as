/**
 *
 * Free Rice Avant Garde - A Bot Experiment
 * Copyright (C) 2011, Sandeep Gupta
 * http://www.sangupta.com/projects/frag
 *
 * The file is licensed under the the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

package com.sangupta.freerice {
	
	import com.sangupta.freerice.subject.ISubject;
	
	import mx.controls.HTML;
	import mx.utils.StringUtil;

	/**
	 * Helper functions to work with freerice.com website
	 * 
	 * @author Sandeep Gupta
	 * @since 19 Sep 2011
	 */
	public class FreeRiceHelper {
		
		private static const INCORRECT_IDENTIFIER:String = 'Incorrect!';
		
		private var htmlDocument:Object = null;
		
		private var question:String = null;
		
		private var category:ISubject = null;
		
		private var answers:Array = null;
		
		private var token:String = null;
		
		public function FreeRiceHelper(html:HTML) {
			var doc:Object = html.htmlLoader.window.document;
			if(doc == null) {
				throw new Error('cannot initialize on null object.');
			}
		
			this.htmlDocument = doc;
			
			// this should be the first decipher as others may depend on it
			this.category = getCategory();

			this.question = StringUtil.trim(this.category.getQuestion(doc));
			this.answers = getAnswers();
			this.token = getQuestionToken();
		}
		
		public function equals(helper:FreeRiceHelper):Boolean {
			if(this.token != null) {
				return this.token == helper.token;
			}
			
			return false;
		}
		
		public function checkIfLastAnswerCorrect():Boolean {
			var incorrect:Object = this.htmlDocument.getElementById('incorrect');
			if(incorrect != null) {
				return false;
			}
			
			return true;
		}
		
		public function getCorrectAnswer():String {
			var incorrect:Object = this.htmlDocument.getElementById('incorrect');
			if(incorrect != null) {
				var ans:String = StringUtil.trim(incorrect.textContent);
				var index:int = ans.indexOf(INCORRECT_IDENTIFIER);
				if(index != -1) {
					ans = ans.substr(index + INCORRECT_IDENTIFIER.length);
					return StringUtil.trim(ans);
				}
			}
			
			return null;
		}
		
		/**
		 * Function to divide the answer into actual question and answer
		 * and then save it in database (if needed) for future retrievals.
		 */
		public function saveCorrectAnswer(correctAnswer:String):void {
			if(correctAnswer == null) {
				return;
			}
			
			var tokens:Array = correctAnswer.split('=');
			
			var ques:String = StringUtil.trim(tokens[0]);
			var ans:String = StringUtil.trim(tokens[1]);
			
			if(question != ques && ques != ans) {
				// for some reason the question looks different
				return;
			}
			
			// all set
			this.category.saveAnswer(this.question, ans);
		}
		
		protected function getAnswers():Array {
			var answerString:String = this.htmlDocument.getElementById('edit-list').value;
			var answers:Array = answerString.split('|');
			return answers;
		}
		
		protected function getCategory():ISubject {
			var cat:Object = this.htmlDocument.getElementById('form_game_div');
			var category:Object = cat.getElementsByClassName('block-title');
			var s:String = category[0].textContent;
			if(s != null) {
				return Category.getCategory(s);
			}
			
			return null;
		}
		
		/**
		 * Identifies the unique question asked.
		 */
		protected function getQuestionToken():String {
			var token:Object = this.htmlDocument.getElementById('edit-token');
			return StringUtil.trim(token.value);
		}
		
		public function getAnswerIndex():uint {
			trace(new Date() + ': Question: "' + question + '" in category "' + category + '" has options: ' + answers + '; token=' + token);
			
			var answer:String = this.category.getAnswer(question);
			trace('\tAnswer: ' + answer);
			
			if(answer != null) {
				return getOptionIndex(answers, answer);
			}
			
			trace('\tUnable to decipher, returning zero.');
			return 0;
		}
		
		public function getOptionIndex(answers:Array, answer:String):uint {
			for(var iter:uint = 0; iter < answers.length; iter++) {
				var option:String = answers[iter];
				if(option == answer) {
					return iter;
				}
			}
			
			trace('\tunable to find correct answer: ' + answer);
			return 0;
		}
		
	}
}
