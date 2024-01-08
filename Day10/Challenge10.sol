// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

contract ToDoList {
    struct Task {
        string content;
        bool isCompleted;
    }

    address public owner;
    Task[] private tasks;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function createTask(string memory _content) public onlyOwner {
        tasks.push(Task(_content, false));
    }

    function deleteTask(uint _index) public onlyOwner {
        require(_index < tasks.length, "Task index is out of bounds");
        for (uint i = _index; i < tasks.length - 1; i++) {
            tasks[i] = tasks[i + 1];
        }
        tasks.pop();
    }

    function updateTask(uint _index, string memory _newContent) public onlyOwner {
        require(_index < tasks.length, "Task index is out of bounds");
        tasks[_index].content = _newContent;
    }

    function toggleComplete(uint _index) public onlyOwner {
        require(_index < tasks.length, "Task index is out of bounds");
        tasks[_index].isCompleted = !tasks[_index].isCompleted;
    }

    function getTask(uint _index) public view returns (string memory, bool) {
        require(_index < tasks.length, "Task index is out of bounds");
        Task memory task = tasks[_index];
        return (task.content, task.isCompleted);
    }

    function viewTask(uint _index) public view returns (string memory content, bool isCompleted) {
        require(_index < tasks.length, "Task index is out of bounds");
        Task storage task = tasks[_index];
        return (task.content, task.isCompleted);
    }
}