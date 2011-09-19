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

package com.sangupta.freerice.subject {
	
	import mx.utils.StringUtil;

	/**
	 * Defines function related to <b>Algebra</b> subject on freerice.com
	 * 
	 * @author Sandeep Gupta
	 * @since 19 Sep 2011
	 */
	public class Algebra extends BaseSubject {
		
		override public function getAnswer(question:String):String {
			var delim:String = null;
			if(question.indexOf('+') != -1) {
				delim = '+';
			} else if (question.indexOf('-') != -1) {
				delim = '-';
			} else if (question.indexOf('*') != -1) {
				delim = '*';
			}
			
			var tokens:Array = question.split(delim);
			var operand1:int = int(StringUtil.trim(tokens[0]));
			var operand2:int = int(StringUtil.trim(tokens[1]));
			
			var result:int = 0;
			switch(delim) {
				case '+':
					result = operand1 + operand2;
					break;

				case '-':
					result = operand1 - operand2;
					break;
				
				case '*':
					result = operand1 * operand2;
					break;
				
				case '+':
					result = operand1 + operand2;
					break;
				
				default:
					throw new Error('operation not supported.');
			}
			
			return String(result);

		}
		
		override public function saveAnswer(question:String, answer:String):void {
			throw new Error('Algebra results are evaluated and not looked up. This should be fixed in code. [' + question + '=' + answer + ']');
		}
	}
}