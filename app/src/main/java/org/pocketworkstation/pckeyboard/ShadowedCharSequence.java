// SPDX-License-Identifier: 0BSD

package org.pocketworkstation.pckeyboard;

import java.util.stream.IntStream;
import java.util.HashSet;

public class ShadowedCharSequence implements CharSequence {
  private CharSequence mShadowing;
  public char replaceWith;

  public ShadowedCharSequence(CharSequence shadow, char repl) {
    this.mShadowing = shadow;
    this.replaceWith = repl;
  }

  // CharSequence
  @Override
  public char charAt(int index) {
    return this.mShadowing.charAt(index);
  }
  //@Override
  //public IntStream chars() {
  //  return this.mShadowing.chars();
  //}
  //@Override
  //public IntStream codePoints() {
  //  return this.mShadowing.codePoints();
  //}
  @Override
  public int length() {
    return this.mShadowing.length();
  }
  @Override
  public CharSequence subSequence(int start, int end) {
    return new ShadowedCharSequence(this.mShadowing.subSequence(start, end), this.replaceWith);
  }
  @Override
  public String toString() {
    return this.mShadowing.toString();
  }

  @Override
  public int hashCode() {
    return this.mShadowing.hashCode();
  }
  @Override
  public boolean equals(Object obj) {
    return this.mShadowing.equals(obj);
  }
}
