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
	
	/**
	 * An abstract class that defines the behavior of any subject on freerice.com
	 * 
	 * @author Sandeep Gupta
	 * @since 19 Sep 2011
	 */
	public class BaseSubject implements ISubject {
		
		public function BaseSubject() {
		}
		
		public function getQuestion(document:Object):String {
			var q:Object = document.getElementById('question-title');
			var qs:String = q.innerHTML;
			var ins:int = qs.indexOf('<b>');
			var ine:int = qs.indexOf('</b>');
			if(ins != -1 && ine != -1) {
				return qs.substring(ins + 3, ine);
			}
			
			throw new Error('cannot decipher question');
		}
		
		public function getAnswer(question:String):String {
			throw new Error('must be implemented in a concrete class');
		}
		
		public function saveAnswer(question:String, answer:String):void {
			throw new Error('must be implemented in a concrete class');
		}
	}
}
