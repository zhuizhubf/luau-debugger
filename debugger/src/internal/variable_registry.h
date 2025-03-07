#pragma once

#include <string_view>
#include <unordered_map>

#include <lua.h>
#include <vector>

#include <internal/scope.h>
#include <internal/variable.h>

namespace luau::debugger {

class VariableRegistry {
 public:
  void clear();
  void update(std::vector<std::vector<lua_State*>> vm_with_ancestors);

  Scope getLocalScope(lua_State* L, int level);
  Scope getUpvalueScope(lua_State* L, int level);
  Scope getGlobalScope();

  Variable createVariable(lua_State* L, std::string_view name, int level);

  std::vector<Variable>* registerVariables(Scope scope,
                                           std::vector<Variable> variables);
  std::vector<Variable>* registerOrUpdateVariables(
      Scope scope,
      std::vector<Variable> variables);
  bool isRegistered(Scope scope) const;
  std::vector<Variable>* getVariables(Scope scope, bool load);
  std::pair<const Scope, std::vector<Variable>>* getVariables(int reference);

  void fetchGlobals(lua_State* L);
  void clearDirtyScopes();

 private:
  void fetch(lua_State* L, lua_State* src);
  void fetchFromStack(lua_State* L, int level, lua_State* src);

 private:
  std::unordered_map<Scope, std::vector<Variable>> variables_;
  int depth_ = 0;
};

}  // namespace luau::debugger