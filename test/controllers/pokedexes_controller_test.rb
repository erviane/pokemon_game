require 'test_helper'

class PokedexesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pokedex = pokedexes(:one)
  end

  test "should get index" do
    get pokedexes_url
    assert_response :success
  end

  test "should get new" do
    get new_pokedex_url
    assert_response :success
  end

  test "should create pokedex" do
    assert_difference('Pokedex.count') do
      post pokedexes_url, params: { pokedex: { base_attack: @pokedex.base_attack, base_defence: @pokedex.base_defence, base_health_point: @pokedex.base_health_point, base_speed: @pokedex.base_speed, element_type: @pokedex.element_type, image_url: @pokedex.image_url, name: @pokedex.name } }
    end

    assert_redirected_to pokedex_url(Pokedex.last)
  end

  test "should show pokedex" do
    get pokedex_url(@pokedex)
    assert_response :success
  end

  test "should get edit" do
    get edit_pokedex_url(@pokedex)
    assert_response :success
  end

  test "should update pokedex" do
    patch pokedex_url(@pokedex), params: { pokedex: { base_attack: @pokedex.base_attack, base_defence: @pokedex.base_defence, base_health_point: @pokedex.base_health_point, base_speed: @pokedex.base_speed, element_type: @pokedex.element_type, image_url: @pokedex.image_url, name: @pokedex.name } }
    assert_redirected_to pokedex_url(@pokedex)
  end

  test "should destroy pokedex" do
    assert_difference('Pokedex.count', -1) do
      delete pokedex_url(@pokedex)
    end

    assert_redirected_to pokedexes_url
  end
end
