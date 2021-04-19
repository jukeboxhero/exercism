defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank(state \\ 0) do
    {:ok, account} = GenServer.start_link(__MODULE__, state)
    account
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
    GenServer.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    execute(account, :balance)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
    execute(account, {:increment, amount})
  end

  defp execute(account, action) do
    try do
      GenServer.call account, action
    catch
      :exit, _ -> {:error, :account_closed}
    end
  end

  def init(state), do: {:ok, state}

  def handle_call(:balance, _from, balance) do
    {:reply, balance, balance}
  end
  def handle_call({:increment, amount}, _from, balance) do
    {:reply, balance, balance + amount}
  end
end
